module NrCifParser
  class Parser

    def initialize( filename )

      @filename = filename

    end

    def record_count

      %x{wc -l #{@filename}}.split.first.to_i

    end

    def each( filter_codes = [] )

      account = {
        parsed: 0,
        records: 0,
        skipped: 0
      }

      File.foreach( @filename ) do |line|

        # nuke any newlines + return if it’s empty
        line.gsub!( /[\n\r]/, '' )
        next if line.strip.empty?

        # pad the string to 80 chars, just in case something’s been truncated somewhere (trailing space shouldn’t be an issue)
        line = line.ljust( 80, ' ' )

        # increment our counter, get a code
        account[:records] += 1
        code = line[0, 2]

        # if we’re not interested in the line, increment skip + bail
        unless filter_codes.empty? or filter_codes.include?( code )

          account[:skipped] += 1
          next

        end

        # find a parser
        record = NrCifParser::get_record_module_for( line[0, 2] )
        unless record.nil?

          # increment parse count + hand back
          yield record.parse( line.strip )
          account[:parsed] += 1

        end

      end

      account

    end

  end
end
