Salva::Application.routes.draw do
  devise_for :users

  resources :states do
    get :list_by_country, :on => :collection
  end

  resources :cities do
    get :list_by_state, :on => :collection
    get :remote_form, :on => :collection
  end

  resources :jobpositioncategories do
     get :filtered_select, :on => :collection
  end

  resources :user_languages, :user_skills, :user_schoolarships, :other_activities, :popular_science_activities, 
            :institutional_activities, :other_teaching_activities, :technical_activities, :user_credits,
            :user_journals, :reviews

  publication_resources_for :articles, :unpublished_articles, :popular_science_works, :outreach_works, :other_works,
                            :teaching_products, :technical_reports, :seminaries, :newspaper_articles

  catalog_resources_for :journals, :publishers, :institutions, :languages, :skilltypes, :schoolarships, :credittypes,
                        :newspapers

  namespace :admin do
    resources :users  do
      get :search_by_fullname, :on => :collection
      get :search_by_username, :on => :collection
      get :autocomplete_form, :on => :collection
      get :edit_status, :on => :member
      get :update_status, :on => :member
      get :user_incharge, :on => :member
    end

    resources :catalogs
    super_catalog_for :cities, :states, :journals, :publishers, :adscriptions, :researchareas, 
                      :schoolarships, :institutions, :periods, :seminarytypes, :prizetypes, :careers, 
                      :institutiontypes, :institutiontitles, :activitytypes, :academicprogramtypes, 
                      :activitygroups, :addresstypes, :articlestatuses, :bookchaptertypes, :roleinbooks, 
                      :booktypes, :chapterinbook_roleinchapters, :conferencescopes, :conferencetypes,
                      :contracttypes, :coursegrouptypes, :credittypes, :degrees, :documenttypes,
                      :genericworkstatuses, :genericworktypes, :groups, :groupmodalities, :idtypes,
                      :languagelevels
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
