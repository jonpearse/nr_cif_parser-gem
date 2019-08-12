module NrCifParser
  class Parser

    def initialize( filename )

      @filename = filename

    end

    def record_count

      %x{wc -l #{@filename}}.split.first.to_i

    end

    def each( filter_codes = [] )

      File.foreach( @filename ) do |line|

        # # split the code out + switch on it
        code = line.slice(0..1)

        # if it’s a known type, and it’s one we’re interested, yield a new record
        yield MAP[code].send( :parse, line ) if MAP.key?( code ) and (filter_codes.empty? or filter_codes.include?( code ))

      end

    end

  end
end
