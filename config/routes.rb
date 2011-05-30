Ticketer::Application.routes.draw do
  
  scope(:path_names => { :new => 'novo', :show => 'visualizar', :edit => 'editar' } ) do 

    resources :locals, :path => 'locais'
    resources :call_histories, :path => 'historico_de_chamadas'
    resources :guidances, :path => 'orientacoes'
    resources :tickets, :path => 'senhas'
    resources :ticket_types, :path => 'tipos_de_senha'
    resources :statuses, :path => 'status'
    resources :status_tickets, :path => 'status_de_senha'

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
  match 'logout' => "session#logout"
end
