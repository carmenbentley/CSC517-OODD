# frozen_string_literal: true

# Base application controller
class ApplicationController < ActionController::Base
  protected

  # The path used after sign in.
  def after_sign_in_path_for(resource)
    redirect_to_home(resource)
  end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    redirect_to_home(resource)
  end

  def redirect_to_home(user)
    if user.is_a? Administrator
      administrators_path
    elsif user.is_a? Realtor
      realtors_path
    else
      hunters_path
    end
  end
end
