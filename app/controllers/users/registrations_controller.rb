class Users::RegistrationsController < Devise::RegistrationsController

  respond_to :json
  # Override sign_up to prevent sign in when registering
  def sign_up(resource_name, resource)
  end

  def show
    user = User.find_by_id(params[:id])
    if user
      render json: {user: user}
    else
      render json: {}, status: 404
    end
  end
end
