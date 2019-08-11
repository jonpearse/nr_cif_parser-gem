module NrCifParser::Record

  class IntermediateLocation < Base

    protected

    def self.code

      'LI'

    end

    def self.definition
      {
        location:         FT::String.new( 7 ),
        location_suffix:  FT::Char.new( true ),
        schedule_arrival: FT::Time.new( true, true ),
        schedule_depart:  FT::Time.new( true, true ),
        schedule_pass:    FT::Time.new( true, true ),
        public_arrival:   FT::Time.new( false, true ),
        public_depart:    FT::Time.new( false, true ),
        platform:         FT::String.new( 3, true ),
        line:             FT::String.new( 3, true ),
        path:             FT::String.new( 3, true ),
        activity:         FT::Activity.new,
        eng_allowance:    FT::Allowance.new,
        path_allowance:   FT::Allowance.new,
        perf_allowance:   FT::Allowance.new
      }
    end

  end

end

NrCifParser::register_record_type( NrCifParser::Record::IntermediateLocation )
