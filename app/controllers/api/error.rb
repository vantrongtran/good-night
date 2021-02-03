module Api
  module Error
    class Base < StandardError
      @@status = nil
      def self.status_code
        @@status
      end
    end

    class Unauthenticated < Base
      @@status = :unauthorized
    end

    class WrongUsernamePassword < Unauthenticated
      @@status = :unauthorized
    end

    class TokenExpired < Unauthenticated
      @@status = :unauthorized
    end
  end
end
