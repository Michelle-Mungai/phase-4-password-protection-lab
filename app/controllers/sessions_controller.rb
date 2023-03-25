class SessionsController < ApplicationController
  def create
        logged_user = User.find_by(username: params[:username])
        if logged_user&.authenticate(params[:password])
            session[:user_id] = logged_user.id
            render json: logged_user
        else
            render json: {error: "Unauthorized Response"}, status:401
        end
    end

    def destroy
        session.delete(:user_id)
        head:no_content
    end
end
