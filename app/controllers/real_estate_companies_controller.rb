# frozen_string_literal: true

# Controller to display Real Estate Companies
class RealEstateCompaniesController < ApplicationController
  include ApplicationHelper

  before_action :authenticate!
  before_action :can_view?, only: :show
  before_action :can_create?, only: %i[new create]
  before_action :can_edit?, only: %i[edit update]
  before_action :can_destroy?, only: %i[destroy]

  def index
    @real_estate_companies = if current_user.is_a? Administrator
                               RealEstateCompany.all
                             elsif current_user.is_a? Realtor
                               company = RealEstateCompany.find_by(
                                 realtor: current_user
                               )
                               company.nil? ? [] : [company]
                             else
                               RealEstateCompany.all
                             end
  end

  def show
    @real_estate_company = RealEstateCompany.find(params[:id])
  end

  def new
    @real_estate_company = RealEstateCompany.new
  end

  def edit
    @real_estate_company = RealEstateCompany.find(params[:id])
  end

  def create
    @real_estate_company = RealEstateCompany.new(allowed_params)
    if @real_estate_company.save
      redirect_to :real_estate_companies
    else
      render action: 'new'
    end
  end

  def update
    @real_estate_company = RealEstateCompany.find(params[:id])
    if @real_estate_company.update_attributes(allowed_params)
      redirect_to :real_estate_companies,
                  flash: { class: 'alert alert-success',
                           notice: 'Successfully Updated!' }
    else
      render action: 'edit'
    end
  end

  def destroy
    @real_estate_company = RealEstateCompany.find(params[:id])
    notice = { class: 'alert alert-success', notice: 'Successfully Deleted!' }
    unless @real_estate_company.destroy
      notice[:class] = 'alert alert-danger'
      notice[:notice] = @real_estate_company.errors.full_messages
      notice[:notice] = notice[:notice].map { |m| "<span>#{m}</span>" }
      notice[:notice] = notice[:notice].join('<br>')
    end
    redirect_to :real_estate_companies, flash: notice
  end

  protected

  def allowed_params
    params.require(:real_estate_company)
          .permit(:id, :name, :website, :address, :size,
                  :founded, :revenue, :synopsis)
  end

  def authenticate!
    redirect_to_home if current_user.nil?
  end

  def can_view?
    return unless current_user.is_a? Realtor

    company = RealEstateCompany.find(params[:id])
    if company.nil? || company.id != current_user.real_estate_company_id
      redirect_to(:real_estate_companies, flash: UNAUTHORIZED_FLASH)
    end
  end

  def can_create?
    if current_user.is_a? Hunter
      redirect_to(:real_estate_companies,
                  flash: UNAUTHORIZED_FLASH)
    end
  end

  def can_edit?
    return if current_user.is_a? Administrator

    if current_user.is_a? Hunter
      redirect_to(:real_estate_companies, flash: UNAUTHORIZED_FLASH)
    else
      company = RealEstateCompany.find(params[:id])
      if company.nil? || company.id != current_user.real_estate_company_id
        redirect_to(:real_estate_companies, flash: UNAUTHORIZED_FLASH)
      end
    end
  end

  def can_destroy?
    return if current_user.is_a? Administrator

    if current_user.is_a? Hunter
      redirect_to(:real_estate_companies, flash: UNAUTHORIZED_FLASH)
    else
      company = RealEstateCompany.find(params[:id])
      if company.nil? || company.id != current_user.real_estate_company_id
        redirect_to(:real_estate_companies, flash: UNAUTHORIZED_FLASH)
      end
    end
  end
end
