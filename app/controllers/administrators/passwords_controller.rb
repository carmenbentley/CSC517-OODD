# frozen_string_literal: true

# Password management for Admin
class Administrators::PasswordsController < Devise::PasswordsController
  # GET /resource/password/new
  def new
    redirect_to :adminstrators
  end

  # POST /resource/password
  def create
    redirect_to :adminstrators
  end

  # GET /resource/password/edit?reset_password_token=abcdef
  def edit
    redirect_to :adminstrators
  end

  # PUT /resource/password
  def update
    redirect_to :adminstrators
  end
end
