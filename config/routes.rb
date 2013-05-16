Search::Application.routes.draw do

  get "keyword_position_report/show"

  get "position_report/show"

  get "search_keyword_report/show"

  root :to => 'search_report#show'
	
	resources :search_logs
	resources :result_browse_logs

  match ':controller(/:action(/:id))(.:format)'
end
