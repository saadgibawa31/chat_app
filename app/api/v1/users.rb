module V1

  class Users < Grape::API

    helpers V1::Helpers::AuthHelper
    before { authenticate_user! }

    resources :users do


      desc 'Listing all Users'

      get do

        User.where.not(id: @current_user.id)

      end

#       desc 'Creating new user'

#       params do

#         requires :name, type: String, desc: 'Name'
#         requires :email, type: String, desc: 'Email'
#         requires :password, type: String, desc: 'Password'
#         requires :password_confirmation, type: String, desc: 'Confirm Password'

#       end

#       post do

#         User.create!({
#           name: params[:name],
#           email: params[:email],
#           password: params[:password],
#           password_confirmation: params[:password_confirmation]
#         })

#       end

#       desc 'Updating User'

#       params do

#         requires :id, type: Integer, desc: 'User Id'
#         requires :name, type: String, desc: 'Name'
#         requires :email, type: String, desc: 'Email'
#         requires :password, type: String, desc: 'Password'
#         requires :password_confirmation, type: String, desc: 'Confirm Password'

#       end

#       put ':id' do

#         user = User.find(params[:id])

#         user.update({
#           name: params[:name], 
#           email: params[:email],
#           password: params[:password],
#           password_confirmation: params[:password_confirmation]
#         })

#       end

#       desc 'Deleting user'

#       params do

#         requires :id, type: String, desc: 'User Id'

#       end

#       delete ':id' do
        
#         User.find(params[:id]).destroy

#       end
    end
  end
end
