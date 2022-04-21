class ApplicationController < ActionController::API
  # Ping this route to smoke test application health
  def health
    render status: 200, plain: "ok"
  end
end
