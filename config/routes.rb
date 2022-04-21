Rails.application.routes.draw do
  mount ActionCable.server => "/cable"

  get "health" => "application#health"
end
