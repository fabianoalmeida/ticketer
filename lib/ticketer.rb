module Ticketer
  class ActiveRecord::Base
    def self.today
      where(:created_at => Date.today.midnight...Date.tomorrow.midnight)
    end
    
    def active?
      status.eql? Status.active unless status.nil?
    end
  end
  ActiveRecord::ConnectionAdapters::OracleEnhancedAdapter.class_eval do
    self.default_sequence_start_value = 1
  end
  
 
end
class Numeric
   def duration
     secs  = (self.to_f * 60).to_i
     mins  = secs / 60
     hours = mins / 60
     days  = hours / 24
     
     if days > 0
       "#{days} dias e #{hours % 24} horas"
     elsif hours > 0
       "#{hours} horas e #{mins % 60} minutos"
     elsif mins > 0
       "#{mins} minutos e #{secs % 60} segundos"
     elsif secs >= 0
       "#{secs} segundos"
     end
   end
end
