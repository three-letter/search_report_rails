Search::Application.routes.draw do

	resources :search_logs
	resources :result_browse_logs

  root :to => 'search_report#index'
  match ':controller(/:action(/:id))(.:format)'
end
