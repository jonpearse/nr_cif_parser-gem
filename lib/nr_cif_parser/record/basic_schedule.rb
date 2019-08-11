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
        type:           FieldTypes::Char.new,
        train_uid:      FieldTypes::String.new( 6 ),
        date_from:      FieldTypes::Date.new,
        date_until:     FieldTypes::Date.new,
        days_run:       FieldTypes::Bit.new( 7 ),
        bank_holiday:   FieldTypes::Char.new( true ),
        status:         FieldTypes::Char.new,
        category:       FieldTypes::String.new( 2 ),
        identity:       FieldTypes::String.new( 4 ),
        headcode:       FieldTypes::Number.new( 4, true ),
        indicator:      FieldTypes::Unused.new( 1 ),
        service_code:   FieldTypes::Number.new( 8 ),
        portion_id:     FieldTypes::Char.new( true ),
        power_type:     FieldTypes::String.new( 3, true ),
        timing_load:    FieldTypes::String.new( 4, true ),
        speed:          FieldTypes::Number.new( 3 ),
        op_character:   FieldTypes::String.new( 6, true ),
        seating_class:  FieldTypes::Char.new( true ),
        sleepers:       FieldTypes::Char.new( true ),
        reservations:   FieldTypes::Char.new( true ),
        connection:     FieldTypes::Unused.new( 1 ),
        catering_code:  FieldTypes::String.new( 4, true ),
        service_brand:  FieldTypes::String.new( 4, true ),
        spare:          FieldTypes::Unused.new( 1 ),
        stp_indicator:  FieldTypes::Char.new
      }
    end
    
  end
  
end

NrCifParser::register_record_type( NrCifParser::Record::BasicSchedule )

