

module V1

  module JsonWebToken

    resource :jwt do 
    
      key = 

      def jwt_encode(payload, exp = 24.hours.from_now)
        payload[:exp] = exp.to_i
        JWT.encode(payload, key)
      end

      def jwt_decode(token)
        decoded = JWT.decode(token, key)
        HashWithIndifferentAccess.new decoded
      end
    end
  end

end