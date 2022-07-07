class UsersController < ApplicationController
  def show
    user = User.find_by(id: session[:user_id])
    if user
      render json: user
    else
      render json: { error: "No user is logged in" }, status: 401
    end
  end
  
  def create
    user = User.create(user_params)
    if user.valid?
      session[:user_id] = user.id
      render json: user, status: 201
    else
      render json: { error: "Invalid username or password" }, status: 422
    end
  end

  private

  def user_params
    params.permit(:username, :password, :password_confirmation)
  end
end
