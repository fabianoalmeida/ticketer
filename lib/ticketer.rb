module Ticketer
  class ActiveRecord::Relation
    def today
      where(:created_at => Date.today.midnight...Date.tomorrow.midnight) 
    end
  end
end
