class CallHistoryObserver < ActiveRecord::Observer

  def after_save(call_history)
    Rails.logger.info "Registering a new call history for ticket '#{call_history.ticket.value}' changed by wicket '#{call_history.wicket.value}'" 
  end

end
