MathematicaBlog::Application.routes.draw do
  get "reload/reload"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action
  match 'post/:year/:title/(*file_path)' => 'posts#show', :as => :post, :format => false
  match 'post/:year/:title', :to => redirect {|env, params| "/post/#{params[:year]}/#{params[:title]}/" }
  match 'post/' => 'posts#index', :as => :post_index
  match 'year/:year' => 'posts#list_year', :as => :list_year
  match 'reload/:year' => 'reload#reload'
  match 'tag/:text' => 'tags#show', :as => :tag, :format => false
  match 'tags/' => 'tags#index', :as => :tag_index
  match 'tags', :to => redirect {|env, params| "/tags/"}
  match 'about', :to => redirect {|env, params| 
    post = Post.find(Rails.application.config.about_id)
    post_path(post.year, post.title, '')
    }

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => redirect {|env,params| "/post/"}

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
