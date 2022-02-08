class SessionsController < ApplicationController
  skip_before_action :authorize, only: :create
  
    def create
        user = User.find_by(username: params[:username])
        # &. is "safe navigation operator"! If user is nil, it will return nil. If not, it can call the authenticate method on user. Equivalent to &&.
        if user&.authenticate(params[:password])
          session[:user_id] = user.id
          render json: user
        else
          render json: { errors: ["Invalid username or password"] }, status: :unauthorized
        end
      end

    def destroy
        session.delete :user_id
        head :no_content
    end

end
