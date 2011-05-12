module Ticketer
  class ActiveRecord::Base
    def self.today
      where(:created_at => Date.today.midnight...Date.tomorrow.midnight) 
    end
  end
end
