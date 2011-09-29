Ticketer::Application.routes.draw do

  scope(:path_names => { :new => 'novo', :show => 'visualizar', :edit => 'editar' } ) do

    resources :reports, :path => 'relatorios', :only => :index do
      get 'tickets_per_day', :path => 'senhas_por_dia', :on => :collection
      get 'tickets_per_month', :path => 'senhas_por_mes', :on => :collection
      get 'attendances_by_days_per_wicket', :path => 'atendimentos_por_dia_por_guiche', :on => :collection
      get 'attendances_by_wickets_per_day', :path => 'atendimentos_por_guiche_por_dia', :on => :collection
      get 'attendances_by_wickets_per_month', :path => 'atendimentos_por_guiche_por_mes', :on => :collection
      get 'waiting_time_by_wicket', :path => 'tempo_de_espera_por_guiche', :on => :collection
      get 'waiting_time_by_day_per_wicket', :path => 'tempo_de_espera_por_dia_por_guiche', :on => :collection
      get 'waiting_time_by_wicket_per_month', :path => 'tempo_de_espera_por_guiche_por_mes', :on => :collection
      get 'waiting_time_by_client', :path => 'tempo_de_espera_por_cliente', :on => :collection
      get 'waiting_time_by_client_per_month', :path => 'tempo_de_espera_por_cliente_por_mes', :on => :collection
    end

    resources :locals, :path => 'locais'
    resources :call_histories, :path => 'historico_de_chamadas'
    resources :guidances, :path => 'orientacoes'
    resources :tickets, :path => 'senhas'
    resources :statuses, :path => 'status'
    resources :status_tickets, :path => 'status_de_senha'

    resources :ticket_type_groups, :path => 'grupos_tipo_de_senha' do
      resources :ticket_types, :path => 'tipos_de_senha'
    end

    resources :places, :path => 'localidades' do

      resources :panels, :path => 'paineis' do
        get 'tickets', :path => 'senhas'
      end

      resources :wickets, :path => 'guiches' do
        get 'tickets', :path => 'senhas'
        get 'call_next', :path => 'chamar_proximo'
        put 'recall', :path => 'rechamar'
        put 'attend', :path => 'atender'
        put 'put_waiting', :path => 'por_em_espera'
        put 'back_available', :path => 'tornar_disponivel'
        delete 'cancel', :path => 'cancelar'
      end
      resources :totems do
        get 'generate_ticket', :path => 'gerar_senha'
      end

    end
  end

  match 'guiches' => "wickets#wicket_home", :as => "wicket_home"
  match 'logout' => "session#logout"
  root :to => 'wickets#wicket_home'

end
