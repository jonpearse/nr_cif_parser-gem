module NrCifParser::Record

  class TiplocDelete < Base

    protected

    def self.code

      'TD'

    end

    def self.definition
      @@_definition ||= {
        tiploc: FT::String.new( 7 )
      }
    end

  end

end

NrCifParser::register_record_type( NrCifParser::Record::TiplocDelete )
