module SecuredGenerator
  extend ActiveSupport::Concern
  class_methods do
    def unique_random attr, str_len
      loop do
        str = SecureRandom.hex str_len
        break str unless exists?(attr => str)
      end
    end
  end
end
