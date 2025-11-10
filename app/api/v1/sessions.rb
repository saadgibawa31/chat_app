module V1

  class Sessions < Grape::API

    helpers V1::Helpers::AuthHelper

    resource :sessions do

      desc 'Register user'

      params do

        requires :name, type: String, desc: 'Name'
        requires :email, type: String, desc: 'Email'
        requires :password, type: String, desc: 'Password'

      end

      post :register do

        user = User.new({
          name: params[:name],
          email: params[:email],
          password: params[:password]
        })

        if user.save
          token = jwt_encode(user_id: user.id)
          {token: token, user: user }
        else
          errors!(user.errors.full_messages, '422')
        end

      end
      
      desc 'Login User'

      params do
        requires :email, type: String, desc: 'Email'
        requires :password, type: String, desc: 'Password'
      end
      
      post :login do
        user = User.find_by(email: params[:email])
        if user && user.authenticate(params[:password])
          token = jwt_encode(user_id: user.id)
          {token: token, user: user}
        else
          error!('Invalid Credentials', 401)
        end
      end
    end
  end
end