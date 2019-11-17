module NrCifParser::Record

  class Header < Base

    protected

    def self.code

      'HD'

    end

    def self.definition
      @@_definition ||= {
        file_mainframe_id:  FT::String.new( 20 ),
        date_of_extract:    FT::Date.new( '%d%m%y' ), # just to be awkward 🙄
        time_of_extract:    FT::Time.new,
        current_file_ref:   FT::String.new( 7 ),
        last_file_ref:      FT::String.new( 7, true ),
        bleed_off_ind:      FT::Char.new,
        version:            FT::Char.new,
        user_extract_start: FT::Date.new( '%d%m%y' ),
        user_extract_end:   FT::Date.new( '%d%m%y')
      }
    end

  end

end

NrCifParser::register_record_type( NrCifParser::Record::Header )
