require 'jwt'
require 'openssl'

module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
      logger.add_tags 'ActionCable', current_user.id
    end

    private

    def find_verified_user
      token = request.params[:token]
      user_data = decode_jwt(token)

      if user_data && (user = User.find_by(id: user_data[:user_id]))
        user
      else
        reject_unauthorized_connection
      end
    end

    def decode_jwt(token)
      public_key_path = Rails.root.join('config', 'keys', 'public_key.pem')

      unless File.exist?(public_key_path)
        Rails.logger.error "Public key not found at #{public_key_path}"
        reject_unauthorized_connection
      end

      public_key = OpenSSL::PKey::RSA.new(File.read(public_key_path))

      decoded = JWT.decode(token, public_key, true, { algorithm: 'RS256' })[0]
      HashWithIndifferentAccess.new(decoded)
    rescue JWT::ExpiredSignature
      Rails.logger.warn 'JWT expired'
      reject_unauthorized_connection
    rescue JWT::DecodeError => e
      Rails.logger.warn "JWT decode error: #{e.message}"
      reject_unauthorized_connection
    end
  end
end
