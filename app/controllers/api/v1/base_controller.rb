class Api::V1::BaseController < ActionController::Base
  respond_to :json

  private
  def authenticate_user
  	@current_user = User.find_by_authentication_token(params[:token])
  	unless @current_user
  		respond_with({:error => "Token is invalid." })
    end
  end

  def current_user
  	@current_user
  end

  def authorize_admin!
      if !@current_user.admin?
        error = { :error => "You must be an admin to do that." }
        render params[:format].to_sym => error, :status => 401
      end
   end

   def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
   end
end
