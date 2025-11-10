# class UsersController < ApplicationController

#   def new

#     @user = User.new

#   end

#   def create 

#     @user = User.new(user_params)

#     if @user.save

#       redirect_to root_path, status: :ok
#       flash[:notice] = "User Created Successfully"

#     else

#       render :new, status: :unprocessable_entity
#       flash[:notice] = "Couldn't Create User"

#     end

#   end

#   def edit

#   end

#   def update 

#     if @user.update(user_params) 
      
#       redirect_to root_path, status: :ok
#       flash[:notice] = "User details updated successfully"

#     else

#       render :edit, status: :unprocessable_entity
#       flash[:notice] = "Couldn't update user details"

#     end

#   end

#   def delete
    
#   end

#   def destroy

#     if @user.destroy

#       redirect_to root_path, status: :ok
#       flash[:notice] = "User deleted successfully"
    
#     else

#       redirect_to root_path, status: :unprocessable_entity
#       flash[:notice] = "Couldn't delete user"

#     end

#   end

#   protected

#   def user_params

#     params.require(:user).permit(:name, :email, :password, :confirm)

# end
