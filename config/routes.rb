Rails.application.routes.draw do
  devise_for :admins
  devise_for :users,
             :path_prefix => 'd',
             :controllers => { sessions: 'users/sessions', registrations: 'users/registrations', passwords: 'users/passwords' } do
    post '/users' => '/users/registrations#new', :as => :sign_up, :constraints => { format: /(json)/ }
  end
  resources :users, :only => [:show]

  match '/403', to: 'errors#error_403', via: :all
  match '/404', to: 'errors#error_404', via: :all
  match '/422', to: 'errors#error_422', via: :all
  match '/500', to: 'errors#error_500', via: :all

  get :ie_warning, to: 'errors#ie_warning'
  get :javascript_warning, to: 'errors#javascript_warning'

  root to: 'pages#home'

  resources :categories, controller: 'quiz_admin/categories' do
    get 'recommendations', to: 'quiz_admin/recommendations#index', on: :collection
    get 'recommendations', to: 'quiz_admin/recommendations#difficulties', on: :member
    resources :recommendations, controller: 'quiz_admin/recommendations', path: 'recommendations/:difficulty', constraints: { difficulty: /(1|2)/ }
    resources :quiz_questions, except: [:index], controller: 'quiz_admin/quiz_questions' do
      resources :quiz_options, controller: 'quiz_admin/quiz_options'
    end
  end

  post :update_difficulty, controller: 'quiz_admin/categories'

  resources :quiz_attempts

  controller :sherlock do
    get :sherlock_index, path: '/sherlock', action: 'index'
    post :search
  end

  controller :disposal_map do
    get :disposal_map, path: '/disposal_map', action: 'index'
    post :map_search, path: '/map_search', action: 'search'
  end

  controller :pages do
    get :home, path: '/home'
    get :contact_us, path: '/contact_us'
    get :about, path: '/about'
    get :pricing, path: '/pricing'
    get :accessibility, path: '/accessibility'
    get :privacy, path: '/privacy'
    get :exposure, path: '/exposure'
  end

  controller :quiz do
    get :start, path: '/start'
    get :quiz, path: '/quiz'
    get :question, path: '/question'
    get :end_quiz, path: '/quiz_result'
    get :results, path: '/results'
    post :next
    post :end_quiz
    post :end_category
  end

  controller :breaches do
    get :breaches, path: '/breaches', action: 'show'
    post :search, path: '/breaches', action: 'search'
  end

  controller :metrics do
    post :store_metric
  end

  get 'result', to: 'registrations#new'

  get '/high_contrast', to: 'application#high_contrast', as: 'high_contrast'
  get '/normal_theme', to: 'application#normal_theme', as: 'normal_theme'

  # get :high_contrast, controller:"application"
  # get :normal_theme, controller:"application"

  resources :link_clicks, only: :create
  resources :visits, only: :index
  resources :registrations, only: [:new, :create]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
