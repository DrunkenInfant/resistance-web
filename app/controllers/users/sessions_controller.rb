class Users::SessionsController < Devise::SessionsController

  respond_to :json

  # POST /sessions
	def create
    self.resource = warden.authenticate!(auth_options)
    sign_in(resource_name, resource)
    return render json: {}, status: :created
	end 

  # GET /sessions/current
  def current
    if current_user
      render json: {
        session: { id: 'current', user_id: current_user.id, csrfToken: form_authenticity_token }
      }, status: :ok
    else
      render json: {
        session: { id: 'current', csrfToken: form_authenticity_token }
      }, status: :ok
    end
  end

  # DELETE /sessions/current
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
