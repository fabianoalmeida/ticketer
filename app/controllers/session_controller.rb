class SessionController < ApplicationController
  
  def logout 
    RubyCAS::Filter.logout(self)
  end
end
