module Ticketer
  class ActiveRecord::Relation
    def today
      where(:created_at => Date.today.midnight...Date.tomorrow.midnight) if self.method_defined? :created_at  
    end
  end
end
