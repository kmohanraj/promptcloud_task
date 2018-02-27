# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new

  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end
  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message!(:notice, :signed_in)
    sign_in(resource_name, resource)
    @user = User.find_by(params[:email])
    # if @user.present? and @user.role == "user"
    if @user.present? & @user.role == "user"
    redirect_to new_organization_path
    elsif @user.role == "admin"
    redirect_to homes_path
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
