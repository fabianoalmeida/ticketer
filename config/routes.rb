Ticketer::Application.routes.draw do
  
  resources :locals, :path => 'locais', :path_names => { :new => 'novo', :show => 'visualizar', :edit => 'editar' }
  
  resources :call_histories, :path => 'historico_de_chamadas', :path_names => { :new => 'novo', :show => 'visualizar', :edit => 'editar' }
  
  resources :guidances, :path => 'orientacoes', :path_names => { :new => 'novo', :edit => 'editar' }
  
  resources :tickets, :path => 'senhas', :path_names => { :new => 'novo', :show => 'visualizar', :edit => 'editar' }
  
  resources :ticket_types, :path => 'tipos_de_senha', :path_names => { :new => 'novo', :show => 'visualizar', :edit => 'editar' }
  
  resources :statuses, :path => 'status', :path_names => { :new => 'novo', :show => 'visualizar', :edit => 'editar' }
  
  resources :status_tickets, :path => 'status_de_senha', :path_names => { :new => 'novo', :show => 'visualizar', :edit => 'editar' }

  resources :places, :path => 'localidades', :path_names => { :new => 'novo', :show => 'visualizar', :edit => 'editar' } do

    resources :panels, :path => 'paineis', :path_names => { :new => 'novo', :show => 'visualizar', :edit => 'editar' }
    resources :wickets, :path => 'guiches', :path_names => { :new => 'novo', :show => 'visualizar', :edit => 'editar' } do 
      get 'tickets', :path => 'senhas'
    end
    resources :totems do
      get 'generate_ticket', :path => 'gerar_senha'
    end

  end
  
  match 'logout' => "session#logout"
end
