Salva::Application.routes.draw do
  devise_for :users

  resources :states do
    get :list_by_country, :on => :collection
  end

  resources :cities do
    get :list_by_state, :on => :collection
    get :remote_form, :on => :collection
  end

  resources :documents
  resources :user_schoolarships

  namespace :admin do
    resources :users
    resources :cities do
      put :move_association, :on => :member
      put :move_associations, :on => :member
      post :destroy_all, :on => :collection
      get :destroy_all_empty_associations, :on => :collection
    end
  end

  namespace :academic_secretary do
    resources :users  do
      get :search_by_fullname, :on => :collection
      get :search_by_username, :on => :collection
      get :autocomplete_form, :on => :collection
      get :list, :on => :collection
      get :edit_status, :on => :member
      get :update_status, :on => :member
      get :user_incharge, :on => :member
    end

    resources :identification_cards do
      get :front, :on => :member
      get :back, :on => :member
    end
  end

  root :to => "academic_secretary/users#index"

  mount Resque::Server.new, :at => '/admin/resque' if Rails.env.to_s == 'production'
end
