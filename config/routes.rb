Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api/docs'
  mount Rswag::Api::Engine => '/api/docs'

  namespace :api do
    namespace :v1, constraints: { format: 'json' } do
      resources :authors, except: :new
      resources :competencies, except: :new
      resources :courses, except: :new
    end
  end
end
