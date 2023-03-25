class UsersController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :error_handler
  def create
    if confirmed_params[:password] == confirmed_params[:password_confirmation]
      new_user = User.create(confirmed_params)
      session[:user_id] = new_user[:id]
      render json: new_user
    else
      render json: { error: "Unprocessable entity" }, status: 422
    end
  end

  def show
    log_in = User.find(session[:user_id])
    render json: log_in
  end

  private

  def confirmed_params
    params.permit(:id, :username, :password, :password_confirmation)
  end

  def error_handler
    render json: { error: 'Unauthorized response' }, status: 401
  end
end
