# frozen_string_literal: true

# Controller to post inquiries
class InquiriesController < ApplicationController
  include ApplicationHelper

  before_action :authenticate!
  before_action :can_create?, only: %i[new create]
  before_action :can_edit?, only: %i[edit update]
  before_action :can_destroy?, only: %i[destroy]

  def index
    house = params[:house_id]
    @inquiries = if current_user.is_a? Administrator
                   inquiries_for_admin(house)
                 elsif current_user.is_a? Realtor
                   inquiries_for_realtor(house)
                 else
                   inquiries_for_hunter(house)
                 end
  end

  def show
    redirect_to :inquiries && return
  end

  def new
    @inquiry = Inquiry.new
    @house = House.find(params[:house_id])
  end

  def create
    @inquiry = Inquiry.new(allowed_params)
    @inquiry.house = House.find(params[:inquiry][:house_id])
    @inquiry.hunter = current_user
    if @inquiry.save
      redirect_to inquiries_path(house_id: @inquiry.house.id), flash: {
        notice: 'Successfully posted the inquiry!',
        class: 'alert alert-success'
      }
    else
      params[:house_id] = params[:inquiry][:house_id]
      render action: 'new'
    end
  end

  def edit
    @inquiry = Inquiry.find(params[:id])
    params[:house_id] = @inquiry.house.id
  end

  def update
    @inquiry = Inquiry.find(params[:id])
    @inquiry.realtor = current_realtor if realtor_signed_in?
    if @inquiry.update_attributes(allowed_params)
      InquiryMailer.realtor_response(@inquiry.hunter).deliver_now unless hunter_signed_in?

      redirect_to inquiries_path(house_id: @inquiry.house.id),
                  flash: { class: 'alert alert-success',
                           notice: 'Successfully Updated!' }
    else
      render action: 'edit'
    end
  end

  def destroy
    @inquiry = Inquiry.find(params[:id])
    notice = { class: 'alert alert-success', notice: 'Successfully Deleted!' }
    unless @inquiry.destroy
      notice[:class] = 'alert alert-danger'
      notice[:notice] = @inquiry.errors.full_messages
      notice[:notice] = notice[:notice].map { |m| "<span>#{m}</span>" }
      notice[:notice] = notice[:notice].join('<br>')
    end
    redirect_to :inquiries, flash: notice
  end

  protected

  def authenticate!
    redirect_to(:hunters) if current_user.nil?
  end

  def can_create?
    flash = {
      notice: 'You are not authorized to perform this action',
      class: 'alert alert-danger'
    }
    (redirect_to :inquiries, flash: flash && return) unless current_user.is_a? Hunter
  end

  def can_edit?
    flash = {
      notice: 'You are not authorized to perform this action',
      class: 'alert alert-danger'
    }
    inquiry = Inquiry.find(params[:id])
    (redirect_to(:inquiries, flash: flash) && return) if inquiry.nil?
    if current_user.is_a?(Hunter) && inquiry.hunter.id != current_user.id
      redirect_to :inquiries, flash: flash
    end
  end

  def can_destroy?
    flash = {
      notice: 'You are not authorized to perform this action',
      class: 'alert alert-danger'
    }
    inquiry = Inquiry.find(params[:id])
    (redirect_to(:inquiries, flash: flash) && return) if inquiry.nil?
    if current_user.is_a?(Hunter) && inquiry.hunter.id != current_user.id
      redirect_to :inquiries, flash: flash
    end
  end

  def allowed_params
    params.require(:inquiry)
          .permit(:id, :subject, :message, :reply, :house_id)
  end

  def inquiries_for_admin(house)
    inquiries = house.nil? ? Inquiry.all : Inquiry.find_by(house_id: house)
    inquiries = [] if inquiries.nil?
    inquiries
  end

  def inquiries_for_realtor(house)
    if current_user.real_estate_company_id.nil?
      redirect_to :edit_realtor_registration, flash: {
        notice: 'Please select a Real Estate Company before proceeding',
        class: 'btn btn-danger'
      }
    end
    where_clause = "houses.real_estate_company_id = #{current_user.real_estate_company_id}"
    where_clause += house.nil? ? '' : " AND houses.id = #{house}"
    Inquiry.joins(:house).where(where_clause)
  end

  def inquiries_for_hunter(house)
    where_clause = "inquiries.hunter_id = #{current_user.id}"
    where_clause += house.nil? ? '' : " AND houses.id = #{house}"
    Inquiry.joins(:house).where(where_clause)
  end
end
