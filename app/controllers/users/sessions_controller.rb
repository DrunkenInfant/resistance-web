class Users::SessionsController < Devise::SessionsController

  respond_to :json
  # POST /users/sign_in
	def create
    self.resource = warden.authenticate!(auth_options)
    sign_in(resource_name, resource)
    return render json: {}, status: :no_content
	end 

  # GET /users/current
  def current
    if current_user
      render json: {user: {id: 'current', email: current_user.email}}
    else
      render json: {}, status: 404
    end

  end

  # DELETE /users/sign_out
  def destroy
    if Devise.sign_out_all_scopes
      sign_out
    else
      sign_out(resource_name)
    end
    render json: {}, status: :no_content
  end

  def failure
    return render json: {errors: {email: "Incorrect email or password."}},
      status: :unprocessable_entity
  end
	
  def auth_options
    opts = super
    opts[:recall] = "#{controller_path}#failure"
    opts
  end
end
