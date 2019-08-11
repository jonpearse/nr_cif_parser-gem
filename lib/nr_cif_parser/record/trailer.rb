module NrCifParser::Record

  class Trailer < Base

    protected

    def self.code

      'ZZ'

    end

    def self.definition
      {}
    end

  end

end

NrCifParser::register_record_type( NrCifParser::Record::Trailer )
