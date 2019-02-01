# frozen_string_literal: true

# Controller to manage hunters
class Administrators::ManageHuntersController < ApplicationController
  include ApplicationHelper

  before_action :authenticate!

  def index
    @hunters = Hunter.all
  end

  def show
    redirect_to '/administrators/manage/hunters'
  end

  def new
    @hunter = Hunter.new
  end

  def create
    @hunter = Hunter.new(allowed_params)
    password = Devise.friendly_token(8)
    @hunter.password = password
    if @hunter.save
      AccountMailer.new_account(@hunter.email, password, :house_hunter).deliver_now
      redirect_to '/administrators/manage/hunters', flash: {
        notice: 'Successfully Created!',
        class: 'alert alert-success'
      }
    else
      render action: 'new'
    end
  end

  def edit
    @hunter = Hunter.find(params[:id])
  end

  def update
    @hunter = Hunter.find(params[:id])
    if @hunter.update_attributes(allowed_params)
      redirect_to '/administrators/manage/hunters', flash: {
        notice: 'Successfully Updated!',
        class: 'alert alert-success'
      }
    else
      render action: 'edit'
    end
  end

  def destroy
    @hunter = Hunter.find(params[:id])
    notice = { class: 'alert alert-success', notice: 'Successfully Deleted!' }
    unless @hunter.destroy
      notice[:class] = 'alert alert-danger'
      notice[:notice] = @hunter.errors.full_messages
      notice[:notice] = notice[:notice].map { |m| "<span>#{m}</span>" }
      notice[:notice] = notice[:notice].join('<br>')
    end
    redirect_to '/administrators/manage/hunters', flash: notice
  end

  protected

  def authenticate!
    return if administrator_signed_in?

    redirect_to :root, flash: UNAUTHORIZED_FLASH
  end

  def allowed_params
    params.require(:hunter)
          .permit(:first_name, :last_name, :email, :phone, :preferred)
  end
end
