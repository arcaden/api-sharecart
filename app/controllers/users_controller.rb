class UsersController < ApplicationController
  skip_before_action :authorize_request, only: :create
  # POST /signup
  
  def index
    @users = User.all
    render json: @users, status: :ok
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: {user: @user}, status: :created
    else
      render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.permit(
      :name,
      :username,
      :email,
      :password,
      :password_confirmation,
    )
  end
end
