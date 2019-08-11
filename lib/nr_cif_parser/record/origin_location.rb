module NrCifParser::Record

  class OriginLocation < Base

    protected

    def self.code

      'LO'

    end

    def self.definition
      {
        location:         FieldTypes::String.new( 7 ),
        location_suffix:  FieldTypes::Char.new( true ),
        schedule_depart:  FieldTypes::Time.new( true ),
        public_depart:    FieldTypes::Time.new,
        platform:         FieldTypes::String.new( 3, true ),
        line:             FieldTypes::String.new( 3, true ),
        eng_allowance:    FieldTypes::Allowance.new,
        path_allowance:   FieldTypes::Allowance.new,
        activity:         FieldTypes::Activity.new( 'TB' ),
        perf_allowance:   FieldTypes::Allowance.new
      }
    end

  end

end

NrCifParser::register_record_type( NrCifParser::Record::OriginLocation )
