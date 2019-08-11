module NrCifParser::Record

  class IntermediateLocation < Base

    protected

    def self.code

      'LI'

    end

    def self.definition
      {
        location:         FieldTypes::String.new( 7 ),
        location_suffix:  FieldTypes::Char.new( true ),
        schedule_arrival: FieldTypes::Time.new( true, true ),
        schedule_depart:  FieldTypes::Time.new( true, true ),
        schedule_pass:    FieldTypes::Time.new( true, true ),
        public_arrival:   FieldTypes::Time.new( false, true ),
        public_depart:    FieldTypes::Time.new( false, true ),
        platform:         FieldTypes::String.new( 3, true ),
        line:             FieldTypes::String.new( 3, true ),
        path:             FieldTypes::String.new( 3, true ),
        activity:         FieldTypes::Activity.new,
        eng_allowance:    FieldTypes::Allowance.new,
        path_allowance:   FieldTypes::Allowance.new,
        perf_allowance:   FieldTypes::Allowance.new
      }
    end

  end

end

NrCifParser::register_record_type( NrCifParser::Record::IntermediateLocation )
