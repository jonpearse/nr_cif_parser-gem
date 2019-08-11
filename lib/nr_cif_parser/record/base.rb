module NrCifParser::Record

  class Base

    # Parse an inbound line of CIF data and return a Record object.
    def self.parse( raw )

      # sanity-check: strings are max 80 chars long
      raise NrCifParser::RecordParserError, "Record too long (expected max 80 characters)" if raw.length > 80

      # dupe out the data so we can destructively parse it without worrying too much
      data = raw.dup

      # does the input look right—is the code correct?
      parsed_code = data.slice!( 0, 2 )
      unless parsed_code == self.code

        raise NrCifParser::RecordParserError, "Trying to parse a message of type #{parsed_code} with #{self.to_s}"

      end

      # start parsing things based on the internal definition
      fields = {}
      self.definition.each_pair do |key, field_type|

        # chop
        value = data.slice!( 0, field_type.length )

        # push back
        begin

          fields[key] = field_type.parse( value ) unless field_type.class == NrCifParser::Record::FieldTypes::Unused

        rescue NrCifParser::RecordParserError => e

          raise NrCifParser::RecordParserError, "#{e.to_s} for #{self.code}/#{key}"

        end

      end

      # return
      self.new( raw, fields )

    end

    protected

    def self.code

      raise StandardError, "You probably shouldn’t be calling NrCifParser::Record::Base#code"

    end

    def self.definition

      raise StandardError, "You probably shouldn’t be calling NrCifParser::Record::Base#definition"

    end

    private

    def initialize( raw, parsed_values )

      # assign to ivars
      @raw = raw
      @values = parsed_values

      # create some getters
      parsed_values.keys.each do |k|

        self.class.send( :define_method, k ) do k
          parsed_values[k]
        end

      end

    end

    def self.get_length_from_definition( definition )

      case definition
      when "date"
        6

      when "time"
        4

      when "timeh"
        5

      when /\A[a-z]+\((\d+)\)\Z/i
        $1.to_i

      else
        1

      end

    end

    def self.process_value( value, definition )

      value.strip!

      case definition
      when "date"
        Date.strptime( value, "%y%m%d" )

      when "time"
        value_to_time( value )

      when "timeh"
        value_to_time( value, true )

      when /\Anumber/
        ( value.empty? ? nil : value.to_i )

      when /\Abit/
        ( value.empty? ? nil : value.to_i( 2 ))

      when /\An(string|char)/
        ( value.empty? ? nil : value )

      else
        value

      end

    end

    def self.value_to_time( value, with_half = false )

      return nil if value.empty?

      # get a base time + work out our seconds
      time = value.gsub( /\A(\d{2})(\d{2})(.*)\Z/, '\1:\2' )
      seconds = ( with_half and value.end_with?( 'H' )) ? '30' : '00'

      "#{time}:#{seconds}"

    end


  end

end
