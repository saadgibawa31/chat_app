module V1
  module Helpers
    module AuthHelper
      
    include V1::Helpers::JwtHelper

      def current_user
        token = headers['Authorization']&.split(" ")&.last
        Rails.logger.info("token : #{token}")
        decoded_token = jwt_decode(token)
        Rails.logger.info("decoded_token : #{decoded_token.inspect}")
        @current_user ||= User.find_by(id: decoded_token[:user_id]) if decoded_token
        Rails.logger.info("user : #{@current_user}")
          
      rescue 
        error!('Unauthorized Or Invalid Token', 401) 
      end
      
      def authenticate_user!
        error!('Unauthorized', 401) unless current_user
      end

    end
  end
end