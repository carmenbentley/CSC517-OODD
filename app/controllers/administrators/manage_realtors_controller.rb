# frozen_string_literal: true

# Controller to manage realtors
class Administrators::ManageRealtorsController < ApplicationController
  include ApplicationHelper

  before_action :authenticate!

  def index
    @realtors = Realtor.all
  end

  def show
    redirect_to '/administrators/manage/realtors'
  end

  def new
    @realtor = Realtor.new
  end

  def create
    @realtor = Realtor.new(allowed_params)
    password = Devise.friendly_token(8)
    @realtor.password = password
    if @realtor.save
      AccountMailer.new_account(@realtor.email, password, :realtor).deliver_now
      redirect_to '/administrators/manage/realtors', flash: {
        notice: 'Successfully Created!',
        class: 'alert alert-success'
      }
    else
      render action: 'new'
    end
  end

  def edit
    @realtor = Realtor.find(params[:id])
  end

  def update
    @realtor = Realtor.find(params[:id])
    if @realtor.update_attributes(allowed_params)
      redirect_to '/administrators/manage/realtors', flash: {
        notice: 'Successfully Updated!',
        class: 'alert alert-success'
      }
    else
      render action: 'edit'
    end
  end

  def destroy
    @realtor = Realtor.find(params[:id])
    notice = { class: 'alert alert-success', notice: 'Successfully Deleted!' }
    unless @realtor.destroy
      notice[:class] = 'alert alert-danger'
      notice[:notice] = @realtor.errors.full_messages
      notice[:notice] = notice[:notice].map { |m| "<span>#{m}</span>" }
      notice[:notice] = notice[:notice].join('<br>')
    end
    redirect_to '/administrators/manage/realtors', flash: notice
  end

  protected

  def authenticate!
    return if administrator_signed_in?

    redirect_to :root, flash: UNAUTHORIZED_FLASH
  end

  def allowed_params
    params.require(:realtor)
          .permit(:first_name, :last_name, :email, :phone_number,
                  :real_estate_company_id)
  end
end
