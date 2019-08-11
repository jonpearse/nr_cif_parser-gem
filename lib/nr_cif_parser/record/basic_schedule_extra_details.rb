module NrCifParser::Record

  class BasicScheduleExtraDetails < Base

    protected

    def self.code

      'BX'

    end

    def self.definition
      {
        traction_class:     FieldTypes::Unused.new( 4 ),
        uic_code:           FieldTypes::Number.new( 5, true ),
        atoc_code:          FieldTypes::String.new( 2 ), # @TODO: make this an enum
        applicable_tt_code: FieldTypes::Enum.new( %w{ Y N })
      }
    end

  end

end

NrCifParser::register_record_type( NrCifParser::Record::BasicScheduleExtraDetails )
