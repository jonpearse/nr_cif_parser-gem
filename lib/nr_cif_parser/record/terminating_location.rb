module NrCifParser::Record

  class TerminatingLocation < Base

    protected

    def self.code

      'LT'

    end

    def self.definition
      {
        location:         FieldTypes::String.new( 7 ),
        location_suffix:  FieldTypes::Char.new( true ),
        schedule_arrival: FieldTypes::Time.new( true),
        public_arrival:   FieldTypes::Time.new( false ),
        platform:         FieldTypes::String.new( 3, true ),
        path:             FieldTypes::String.new( 3, true ),
        activity:         FieldTypes::Activity.new( 'TF' ),
      }
    end

  end

end

NrCifParser::register_record_type( NrCifParser::Record::TerminatingLocation )
