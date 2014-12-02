RedmineApp::Application.routes.draw do
  match 'issues/(:id)/like', :to => 'favourites#like'#, :via => 'POST'
  match 'issues/(:id)/unlike', :to => 'favourites#unlike'#, :via => 'POST'
end
