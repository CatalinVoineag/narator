Rails.application.routes.draw do
  resources :categories
  mount SolidQueueDashboard::Engine, at: "/solid-queue"

  resources :contents

  get "up" => "rails/health#show", as: :rails_health_check
end
