module NrCifParser::Record::Mixins
  
  module RunningDays
    
    DAYS = %i{ monday tuesday wednesday thursday friday saturday sunday }
    
    def self.included( base )
      
      base.send :extend, ClassMethods
      base.send :include, InstanceMethods
      
      # also, some dynamic methods to save typing =)
      DAYS.each_with_index do |day, offset|

        base.send( :define_method, "on_#{day}?" ) do
          
          runs_on_day( offset )
          
        end
        
      end
      
    end
    
    module ClassMethods
    
      @@runningDaysFieldName ||= nil
    
      def hook_running_days( field )
        
        @@runningDaysFieldName = field

      end
      
      def getFieldName
        
        @@runningDaysFieldName
        
      end
      
    end
    
    module InstanceMethods
      
      def running_days
        
        DAYS.map.with_index{ |d,i| runs_on_day( i )}
        
      end
      
      def running_days_in_words
        
        DAYS.map.with_index{ |d,i| [ d, runs_on_day( i )]}.to_h
        
      end
      
      def runs_on_day( day_index )
        


        bit_val = 2 ** ( 6 - day_index )      
        ( @values[self.class.getFieldName] & bit_val ) == bit_val
        
      end
      
    end
        
  end
  
end