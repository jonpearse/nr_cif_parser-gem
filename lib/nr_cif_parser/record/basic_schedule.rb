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
        type:           "char",
        train_uid:      "string(6)",
        date_from:      "date",
        date_until:     "date",
        days_run:       "bit(7)",
        bank_holiday:   "nchar",
        status:         "char",
        category:       "string(2)",
        identity:       "string(4)",
        headcode:       "number(4)",
        indicator:      "unused(1)",
        service_code:   "number(8)",
        portion_id:     "nchar",
        power_type:     "nstring(3)",
        timing_load:    "nstring(4)",
        speed:          "number(3)",
        op_character:   "nstring(6)",
        seating_class:  "nchar",
        sleepers:       "nchar",
        reservations:   "nchar",
        connection:     "unused(1)",
        catering_code:  "nstring(4)",
        service_brand:  "nstring(4)",
        spare:          "unused(1)",
        stp_indicator:  "char"
      }
    end
    
  end
  
end

NrCifParser::register_record_type( NrCifParser::Record::BasicSchedule )

