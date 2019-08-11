module NrCifParser::Record

  class TiplocDelete < Base

    protected

    def self.code

      'TD'

    end

    def self.definition
      {
        tiploc: FieldTypes::String.new( 7 )
      }
    end

  end

end

NrCifParser::register_record_type( NrCifParser::Record::TiplocDelete )
