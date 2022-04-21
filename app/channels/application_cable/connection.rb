module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = authenticate!
    end

    protected

    def authenticate!
      user = test_user

      user || reject_unauthorized_connection
    end

    def test_user
      request.params['test_user']
    end
  end
end
