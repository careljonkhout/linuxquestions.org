ActionController::Routing::Routes.draw do |map|

#  map.site_search  'search', :controller => 'front', :action => 'search'
  map.root :controller => 'quizzes', :action => 'index'

  Hobo.add_routes(map)

  map.rate_question 'questions/:id/rate', :controller => :questions, :action => :rate, :method => :post
end
