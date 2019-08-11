module NrCifParser::Record

  class TiplocInsert < Base

    protected

    def self.code

      'TI'

    end

    def self.definition
      {
        tiploc:           FieldTypes::String.new( 7 ),
        capitals_id:      FieldTypes::Number.new( 2, false, true ),
        nalco:            FieldTypes::Number.new( 6, false, true ),
        nlc_check_num:    FieldTypes::Char.new( true ),
        tps_description:  FieldTypes::String.new( 26, true ),
        stanox:           FieldTypes::Number.new( 5, false, true ),
        po_mcp_code:      FieldTypes::Number.new( 4, false, true ),
        crs_code:         FieldTypes::String.new( 3, true ),
        description:      FieldTypes::String.new( 16, true )
      }
    end

  end

end

NrCifParser::register_record_type( NrCifParser::Record::TiplocInsert )
