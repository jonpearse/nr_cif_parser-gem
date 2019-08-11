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
        type:           FieldTypes::Enum.new( %w{ N D R } ),
        train_uid:      FieldTypes::String.new( 6, false, /[A-Z]\d{5}/ ),
        date_from:      FieldTypes::Date.new,
        date_until:     FieldTypes::Date.new,
        days_run:       FieldTypes::Bit.new( 7 ),
        bank_holiday:   FieldTypes::Enum.new( %w{ E G X }, true ),
        status:         FieldTypes::Enum.new( %w{ B F P S T 1 2 3 4 5 }),
        category:       FieldTypes::String.new( 2 ), # @TODO: expand to ENUM
        identity:       FieldTypes::String.new( 4, false, /\d[A-Z]\d\d/ ),
        headcode:       FieldTypes::Number.new( 4, true ),
        indicator:      FieldTypes::Unused.new( 1 ),
        service_code:   FieldTypes::Number.new( 8 ),
        portion_id:     FieldTypes::Char.new( true, /[ Z1248]/ ),
        power_type:     FieldTypes::Enum.new( %w{ D DEM DMU E ED EML EMU HST }),
        timing_load:    FieldTypes::String.new( 4, true, /\A(A|E|N|S|T|V|X|D[1-3]|\d{1,4})\s*\Z/ ),
        speed:          FieldTypes::Number.new( 3 ),
        op_character:   FieldTypes::String.new( 6, true, /\A[BCDEGMPQRSYZ]*\s*\Z/ ),
        seating_class:  FieldTypes::Enum.new( %w{ B S }, true ),
        sleepers:       FieldTypes::Enum.new( %w{ B F S }, true ),
        reservations:   FieldTypes::Enum.new( %w{ A E R S }, true ),
        connection:     FieldTypes::Unused.new( 1 ),
        catering_code:  FieldTypes::String.new( 4, true, /\A[CFHMRT]*\s*\Z/ ),
        service_brand:  FieldTypes::String.new( 4, true, /\AE?\s*\Z/ ),
        spare:          FieldTypes::Unused.new( 1 ),
        stp_indicator:  FieldTypes::Enum.new( %w{ C N O P })
      }
    end

  end

end

NrCifParser::register_record_type( NrCifParser::Record::BasicSchedule )
