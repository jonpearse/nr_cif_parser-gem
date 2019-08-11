module NrCifParser::Record

  class Header < Base

    protected

    def self.code

      'HD'

    end

    def self.definition
      {
        file_mainframe_id:  FieldTypes::String.new( 20 ),
        date_of_extract:    FieldTypes::Date.new( '%d%m%y' ), # just to be awkward 🙄
        time_of_extract:    FieldTypes::Time.new,
        current_file_ref:   FieldTypes::String.new( 7 ),
        last_file_ref:      FieldTypes::String.new( 7, true ),
        bleed_off_ind:      FieldTypes::Char.new,
        version:            FieldTypes::Char.new,
        user_extract_start: FieldTypes::Date.new( '%d%m%y' ),
        user_extract_end:   FieldTypes::Date.new( '%d%m%y')
      }
    end

  end

end

NrCifParser::register_record_type( NrCifParser::Record::Header )
