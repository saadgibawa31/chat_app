require 'jwt'

module V1
  module Helpers
    module JwtHelper

      
      def jwt_encode(payload, exp = 24.hours.from_now)
        
        private_key = OpenSSL::PKey::RSA.new(File.read(Rails.root.join('config', 'keys', 'private_key.pem')))     

        payload[:exp] = exp.to_i
        JWT.encode(payload, private_key, 'RS256')
      end
      
      def jwt_decode(token)

        Rails.logger.info("Decode: #{token}")
        public_key  = OpenSSL::PKey::RSA.new(File.read(Rails.root.join('config', 'keys', 'public_key.pem')))
        Rails.logger.info("Public Key: #{public_key}")
        
        decoded = JWT.decode(token, public_key, true, {algorithm: 'RS256'})[0]
        Rails.logger.info("Decoded: #{decoded.inspect}")
        HashWithIndifferentAccess.new(decoded)
        
      rescue JWT::DecodeError => e
        Rails.logger.info("Decode Error: #{e.message}")
        nil
      end

    end
  end
end
      

