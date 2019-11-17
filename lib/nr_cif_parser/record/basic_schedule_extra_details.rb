module NrCifParser::Record

  class BasicScheduleExtraDetails < Base

    protected

    def self.code

      'BX'

    end

    def self.definition
      @@_definition ||= {
        traction_class:     FT::Unused.new( 4 ),
        uic_code:           FT::Number.new( 5, true ),
        atoc_code:          FT::String.new( 2 ), # @TODO: make this an enum
        applicable_tt_code: FT::Enum.new( %w{ Y N })
      }
    end

  end

end

NrCifParser::register_record_type( NrCifParser::Record::BasicScheduleExtraDetails )
