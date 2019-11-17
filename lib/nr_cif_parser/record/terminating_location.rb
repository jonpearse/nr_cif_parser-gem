module NrCifParser::Record

  class TerminatingLocation < Base

    protected

    def self.code

      'LT'

    end

    def self.definition
      @@_definition ||= {
        location:         FT::String.new( 7 ),
        location_suffix:  FT::Char.new( true ),
        schedule_arrival: FT::Time.new( true),
        public_arrival:   FT::Time.new( false ),
        platform:         FT::String.new( 3, true ),
        path:             FT::String.new( 3, true ),
        activity:         FT::Activity.new( 'TF' ),
      }
    end

  end

end

NrCifParser::register_record_type( NrCifParser::Record::TerminatingLocation )
