module NrCifParser::Record

  class OriginLocation < Base

    protected

    def self.code

      'LO'

    end

    def self.definition
      {
        location:         FT::String.new( 7 ),
        location_suffix:  FT::Char.new( true ),
        schedule_depart:  FT::Time.new( true ),
        public_depart:    FT::Time.new,
        platform:         FT::String.new( 3, true ),
        line:             FT::String.new( 3, true ),
        eng_allowance:    FT::Allowance.new,
        path_allowance:   FT::Allowance.new,
        activity:         FT::Activity.new( 'TB' ),
        perf_allowance:   FT::Allowance.new
      }
    end

  end

end

NrCifParser::register_record_type( NrCifParser::Record::OriginLocation )
