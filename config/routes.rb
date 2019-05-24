Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get "home/index"
  
  post "letter/send_letter"
  get "letter/send_letter"
  
  root :to => 'home#index'
  
end
