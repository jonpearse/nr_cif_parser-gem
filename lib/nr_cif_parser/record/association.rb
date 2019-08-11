module NrCifParser::Record

  class Association < Base
    include Mixins::RunningDays

    hook_running_days( :days )

    protected

    def self.code

      'AA'

    end

    def self.definition
      {
        type:             FieldTypes::Enum.new( %w{ N D R } ),
        main_uid:         FieldTypes::String.new( 6, false, /[A-Z]\d{5}/ ),
        associated_uid:   FieldTypes::String.new( 6, false, /[A-Z]\d{5}/ ),
        date_from:        FieldTypes::Date.new,
        date_until:       FieldTypes::Date.new,
        days:             FieldTypes::Bit.new( 7 ),
        category:         FieldTypes::Enum.new( %w{ JJ VV NP }, true ),
        date_ind:         FieldTypes::Enum.new( %w{ S N P } ),
        location:         FieldTypes::String.new( 7 ),
        base_suffix:      FieldTypes::Number.new( 1, true ),
        assoc_suffix:     FieldTypes::Number.new( 1, true ),
        diagram_type:     FieldTypes::Unused.new( 1 ),
        association_type: FieldTypes::Enum.new( %w{ P O }, true ),
        spare:            FieldTypes::Unused.new( 31 ),
        stp_indicator:    FieldTypes::Enum.new([ ' ', 'C', 'N', 'O', 'P' ])
      }
    end

  end

end

NrCifParser::register_record_type( NrCifParser::Record::Association )
