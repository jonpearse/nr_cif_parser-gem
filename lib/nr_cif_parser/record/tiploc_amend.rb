module NrCifParser::Record

  class TiplocAmend < Base

    protected

    def self.code

      'TA'

    end

    def self.definition
      @@_definition ||= {
        tiploc:           FT::String.new( 7 ),
        capitals_id:      FT::Number.new( 2, false, true ),
        nalco:            FT::Number.new( 6, false, true ),
        nlc_check_num:    FT::Char.new( true ),
        tps_description:  FT::String.new( 26, true ),
        stanox:           FT::Number.new( 5, false, true ),
        po_mcp_code:      FT::Number.new( 4, false, true ),
        crs_code:         FT::String.new( 3, true ),
        description:      FT::String.new( 16, true ),
        new_tiploc:       FT::String.new( 7, true )
      }
    end

  end

end

NrCifParser::register_record_type( NrCifParser::Record::TiplocAmend )
