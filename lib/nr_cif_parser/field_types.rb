require 'date'

module NrCifParser::FieldTypes

  class Base

    def initialize( length, nullable = false )

      @length = length
      @nullable = nullable

    end

    def parse( value )

      value.strip!
      ( @nullable && value.empty? ) ? nil : value

    end

    def length

      @length

    end

    def nullable?

      @nullable

    end

  end

  class String < Base

    def initialize( length, nullable = false, match = nil )

      super( length, nullable )

      @match = match

    end

    def parse( value )

      # empty?
      raise NrCifParser::RecordParserError, "Can’t be blank" if value.strip.empty? and !@nullable

      # match!
      raise NrCifParser::RecordParserError, "Invalid #{value}" unless @match.nil? or value.match?( @match )

      # pass up
      super( value )

    end

  end

  class Char < String

    def initialize( nullable = false, match = nil )

      super( 1, nullable, match )

    end

  end

  class Date < Base

    def initialize( parse_format = '%y%m%d' )

      @parse_format = parse_format

      super( 6, false )

    end

    def parse( value )

      ::Date.strptime( value, @parse_format )

    rescue

      raise NrCifParser::RecordParserError, "Badly-formatted date ‘#{value}’"

    end

  end

  class Time < Base

    def initialize( supports_halves = false, nullable = false )

      @supports_halves = supports_halves

      super(( supports_halves ? 5 : 4 ), nullable )

    end

    def parse( value )

      value.strip!

      # handle empty values
      if value.empty? && @nullable

        return nil

      elsif value.empty?

        raise NrCifParser::RecordParserError, "Cannot have empty time field"

      elsif !value.strip.match?( /\A([0-1][0-9]|2[0-3])([0-5][0-9])H?\Z/ )

        raise NrCifParser::RecordParserError, "Invalid time #{value}"

      end

      # otherwise…
      time = value.gsub( /\A(\d{2})(\d{2})(.*)\Z/, '\1:\2' )
      seconds = ( @supports_halves and value.end_with?( 'H' )) ? '30' : '00'

      "#{time}:#{seconds}"

    end

  end

  class Bit < Base

    def initialize( length )

      super( length, false )

    end

    def parse( value )

      value.strip!

      raise NrCifParser::RecordParserError, "Invalid bit value #{value}" unless value.match( /\A[01]+\Z/) and !value.empty?

      ( value.empty? ? 0 : value.to_i( 2 ))

    end

  end

  class Enum < Base

    def initialize( values, nullable = false )

      @allowed_values = values

      super( values.max{ |a, b| a.length <=> b.length }.length, nullable )

    end

    def parse( value )

      # null values
      if value.strip.empty? && @nullable

        return nil

      end

      # otherwise, check the value in our list of allowed
      value.strip! unless value.strip.empty?
      unless @allowed_values.include?( value )

        raise NrCifParser::RecordParserError, "Value #{value} is not allowed"

      end

      value

    end

  end

  class Number < Base

    def initialize( length, nullable = false, required = false )

      @required = required

      super( length, nullable )

    end

    def parse( value )

      value.strip!

      # if it’s empty + we’re not required
      return ( nullable? ? nil : 0 ) if value.empty? and !@required

      # check format
      raise NrCifParser::RecordParserError, "Empty field" if value.empty?
      raise NrCifParser::RecordParserError, "Must be numeric" if value.match?( /\D/ )

      value.to_i

    end

  end

  class Allowance < Base

    def initialize

      super( 2, false )

    end

    def parse( value )

      # if we’ve nothing…
      return 0 if value.strip.empty?

      # do some validation
      raise NrCifParser::RecordParserError, "Invalid allowance #{value}" unless value.strip.match?( /\A\d[H\d]?\Z/ )

      # be lazy
      value.gsub( 'H', '.5' ).to_f

    end

  end

  class Activity < Base

    TYPES = %w{ A AE AX BL C D -D E G H HH K KC KE KF KS L N OP OR PR R PM RR S T -T TB TF TS TW U -U W X }

    def initialize( required = nil )

      @required = required

      super( 12 )

    end

    def parse( value )

      # split out into tokens
      value = value.chars.each_slice( 2 ).map{ |v| v.join.strip }.reject{ |v| v.empty? }

      # now, ensure we don’t have any errant values
      value.each{ |v| raise NrCifParser::RecordParserError, "Unknown activity #{v}" unless TYPES.include?( v ) }

      # finally, complain if we don’t have something we need
      raise NrCifParser::RecordParserError, "Missing required #{@required}" unless @required.nil? or value.include?( @required )

      # return
      value

    end

  end

  class Unused < Base; end

end
