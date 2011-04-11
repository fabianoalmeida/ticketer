class Place < ActiveRecord::Base

  #String :value
  #String :user
  #Integer :status_id

  has_one :status
  has_one :local
  has_many :wickets
  has_many :tickets
  has_many :panels
  has_many :totems

end
