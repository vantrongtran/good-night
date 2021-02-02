module Api
  module Error
    class Base < StandardError
      @@status = nil
      def self.status_code
        @@status
      end
    end

    class WrongUsernamePassword < Base
      @@status = :unauthorized
    end
  end
end
