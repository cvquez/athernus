# == Route Map

Rails.application.routes.draw do
  root 'site#index'

  get '/athernus/:slug', to: 'site#new', as: 'new_athernus'
  post '/athernus/', to: 'site#create', as: 'athernus'
  get '/thanks', to: 'site#thanks', as: 'thanks'

  match '/404', to: 'error#not_found', via: %i[delete get patch post put]
  match '/422', to: 'error#unprocessable_entity', via: %i[delete get patch post put]
  match '/500', to: 'error#internal_server_error', via: %i[delete get patch post put]

  devise_for :admins, controllers: { sessions: 'admins/sessions' }

  scope 'administrador' do
    root to: 'admin#index', as: 'admin_index'
    resources :questionnaire_types
    resources :questionnaires
    resources :dimensions
    resources :focus_areas
    resources :business_dimensions
    resources :questions
    resources :people
    resources :responses
    resources :answers
    resources :roles
    resources :permissions
    resources :admins
    resources :settings, only: %i[index create]
    resources :request_logs
  end
end
