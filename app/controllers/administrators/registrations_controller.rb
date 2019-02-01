# frozen_string_literal: true

# Registration Controller for Admins
class Administrators::RegistrationsController < Devise::RegistrationsController
  prepend_before_action :admin_cannot_be_destroyed, only: :destroy

  # GET /resource/sign_up
  def new
    redirect_to :adminstrators
  end

  # POST /resource
  def create
    redirect_to :adminstrators
  end

  # GET /resource/edit
  def edit
    redirect_to :adminstrators
  end

  # PUT /resource
  def update
    redirect_to :adminstrators
  end

  # DELETE /resource
  def destroy
    redirect_to :adminstrators
  end

  protected

  def admin_cannot_be_destroyed!
    redirect_to :adminstrators
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end
end
