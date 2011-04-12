class Place < ActiveRecord::Base

  #String :value
  #String :user
  #Integer :status_id

  belongs_to :status
  belongs_to :local
  has_many :wickets
  has_many :tickets
  has_many :panels
  has_many :totems

end
