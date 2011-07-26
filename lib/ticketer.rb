module Ticketer
  class ActiveRecord::Base
    def self.today
      where(:created_at => Date.today.midnight...Date.tomorrow.midnight)
    end
  end
  ActiveRecord::ConnectionAdapters::OracleEnhancedAdapter.class_eval do
    self.default_sequence_start_value = 1
  end
end
