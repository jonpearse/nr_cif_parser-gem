module NrCifParser::Record

  class BasicSchedule < Base
    include Mixins::RunningDays

    hook_running_days( :days_run )

    protected

    def self.code

      'BS'

    end

    def self.definition
      {
        type:           FT::Enum.new( %w{ N D R } ),
        train_uid:      FT::String.new( 6, false, /[A-Z]\d{5}/ ),
        date_from:      FT::Date.new,
        date_until:     FT::Date.new,
        days_run:       FT::Bit.new( 7 ),
        bank_holiday:   FT::Enum.new( %w{ E G X }, true ),
        status:         FT::Enum.new( %w{ B F P S T 1 2 3 4 5 }, true ),
        category:       FT::String.new( 2, true ), # @TODO: expand to ENUM
        identity:       FT::String.new( 4, true, /(\d[A-Z]\d\d|\s)/ ),
        headcode:       FT::String.new( 4, true ), # spec says number, but real data includes letters for bus routes
        indicator:      FT::Unused.new( 1 ),
        service_code:   FT::Number.new( 8 ),
        portion_id:     FT::Char.new( true, /[ Z01248]/ ),
        power_type:     FT::Enum.new( %w{ D DEM DMU E ED EML EMU HST }, true ),
        timing_load:    FT::String.new( 4, true, /\A(A|E|N|S|T|V|X|D[1-3]|\d{1,4})?\s*\Z/ ),
        speed:          FT::Number.new( 3 ),
        op_character:   FT::String.new( 6, true, /\A[BCDEGMPQRSYZ]*\s*\Z/ ),
        seating_class:  FT::Enum.new( %w{ B S }, true ),
        sleepers:       FT::Enum.new( %w{ B F S }, true ),
        reservations:   FT::Enum.new( %w{ A E R S }, true ),
        connection:     FT::Unused.new( 1 ),
        catering_code:  FT::String.new( 4, true, /\A[CFHMRT]*\s*\Z/ ),
        service_brand:  FT::String.new( 4, true, /\A(E|U)?\s*\Z/ ),
        spare:          FT::Unused.new( 1 ),
        stp_indicator:  FT::Enum.new( %w{ C N O P })
      }
    end

  end

end

NrCifParser::register_record_type( NrCifParser::Record::BasicSchedule )
