# frozen_string_literal: true

class Administrators::UnlocksController < Devise::UnlocksController
  # GET /resource/unlock/new
  def new
    redirect_to :adminstrators
  end

  # POST /resource/unlock
  def create
    redirect_to :adminstrators
  end

  # GET /resource/unlock?unlock_token=abcdef
  def show
    redirect_to :adminstrators
  end
end
