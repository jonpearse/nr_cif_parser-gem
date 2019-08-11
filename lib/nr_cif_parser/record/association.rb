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
        type:             FT::Enum.new( %w{ N D R } ),
        main_uid:         FT::String.new( 6, false, /[A-Z]\d{5}/ ),
        associated_uid:   FT::String.new( 6, false, /[A-Z]\d{5}/ ),
        date_from:        FT::Date.new,
        date_until:       FT::Date.new,
        days:             FT::Bit.new( 7 ),
        category:         FT::Enum.new( %w{ JJ VV NP }, true ),
        date_ind:         FT::Enum.new( %w{ S N P } ),
        location:         FT::String.new( 7 ),
        base_suffix:      FT::Number.new( 1, true ),
        assoc_suffix:     FT::Number.new( 1, true ),
        diagram_type:     FT::Unused.new( 1 ),
        association_type: FT::Enum.new( %w{ P O }, true ),
        spare:            FT::Unused.new( 31 ),
        stp_indicator:    FT::Enum.new([ ' ', 'C', 'N', 'O', 'P' ])
      }
    end

  end

end

NrCifParser::register_record_type( NrCifParser::Record::Association )
