Ticketer::Application.routes.draw do
  resources :locals, :call_histories, :guidances, :call_history_types, 
            :tickets, :ticket_types, :statuses, :status_tickets

  resources :places do

    resources :panels
    resources :wickets do 
      get 'tickets'
    end
    resources :totems do
      get 'generate_ticket'
    end

  end
  
  match 'logout' => "session#logout"
end
