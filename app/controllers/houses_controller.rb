# frozen_string_literal: true

# Houses controller
class HousesController < ApplicationController
  include HousesHelper
  include ApplicationHelper

  before_action :authenticate!
  before_action :can_create?, only: %i[new create]
  before_action :can_edit?, only: %i[edit update]
  before_action :can_destroy?, only: %i[destroy]

  def index
    @houses = House.all
  end

  def show
    @house = House.find(params[:id])
  end

  def new
    @house = House.new
  end

  def edit
    @house = House.find(params[:id])
  end

  def create
    @house = House.new(allowed_params)
    @house.real_estate_company = current_user.real_estate_company
    @house.realtor = current_realtor
    if @house.save
      redirect_to :houses, flash: {
        class: 'alert alert-success',
        notice: 'Successfully Created the House'
      }
    else
      render action: 'new'
    end
  end

  def update
    @house = House.find(params[:id])
    if @house.update_attributes(allowed_params)
      redirect_to :houses,
                  flash: {
                    class: 'alert alert-success',
                    notice: 'Successfully Updated!'
                  }
    else
      render action: 'edit'
    end
  end

  def destroy
    @house = House.find(params[:id])
    @house.photo.purge
    notice = { class: 'alert alert-success', notice: 'Successfully Deleted!' }
    unless @house.destroy
      notice[:class] = 'alert alert-danger'
      notice[:notice] = @house.errors.full_messages.map { |m| "<span>#{m}</span>" }.join('<br>')
    end
    redirect_to :houses, flash: notice
  end

  def add_to_wl
    (redirect_to(:houses, flash: UNAUTHORIZED_FLASH) && return) unless hunter_signed_in?

    house = House.find(params[:id])
    if house.nil? || current_user.houses.include?(house)
      redirect_to :houses, flash: {
        notice: 'Already in the Wishlist',
        class: 'alert alert-warn'
      }
    end
    current_hunter.houses << house
    redirect_to :houses, flash: {
      notice: 'Added to wishlist',
      class: 'alert alert-success'
    }
  end

  def remove_from_wl
    (redirect_to(:houses, flash: UNAUTHORIZED_FLASH) && return) unless hunter_signed_in?

    house = House.find(params[:id])
    if house.nil? || !current_user.houses.include?(house)
      redirect_to :houses, flash: {
        notice: 'No such house in the Wishlist',
        class: 'alert alert-warn'
      }
    end
    current_hunter.houses.delete house
    redirect_to :houses, flash: {
      notice: 'Removed from Wishlist',
      class: 'alert alert-success'
    }
  end

  def search
    if params.include?(:search)
      @search_params = FormObject.new(search_params)
      @houses = find_houses(@search_params)
      if @houses.empty?
        flash[:notice] = 'Sorry no results :('
      else
        flash.clear
      end
    else
      @search_params = FormObject.new
      @houses = []
      flash.clear
    end
  end

  protected

  def authenticate!
    redirect_to :hunters if current_user.nil?
  end

  def can_create?
    redirect_to :houses, flash: UNAUTHORIZED_FLASH if hunter_signed_in?
  end

  def can_edit?
    return if administrator_signed_in?

    (redirect_to(:houses, flash: UNAUTHORIZED_FLASH) && return) if hunter_signed_in?

    house = House.find(params[:id])
    redirect_to(:houses, flash: UNAUTHORIZED_FLASH) if house.nil? ||
                                                       house.realtor != current_realtor
  end

  def can_destroy?
    return if administrator_signed_in?

    (redirect_to :houses, flash: UNAUTHORIZED_FLASH && return) if hunter_signed_in?

    house = House.find(params[:id])
    redirect_to(:houses, flash: UNAUTHORIZED_FLASH) if house.nil? ||
                                                       house.realtor != current_realtor
  end

  def allowed_params
    params.require(:house).permit(:location, :square_footage, :year_built,
                                  :style, :list_price, :num_floors, :basement,
                                  :owner, :photo)
  end

  def search_params
    params.require(:search).permit(:location, :min_price, :max_price,
                                   :min_area, :max_area, :style)
  end

  def find_houses(query)
    houses = House.all
    unless query.location.nil? || query.location.empty?
      houses = houses.where('location LIKE ?', "%#{query.location.downcase}%")
    end
    unless query.min_price.nil? || query.min_price.empty?
      houses = houses.where('list_price >= ?', query.min_price.to_f)
    end
    unless query.max_price.nil? || query.max_price.empty?
      houses = houses.where('list_price <= ?', query.max_price.to_f)
    end
    unless query.min_area.nil? || query.min_area.empty?
      houses = houses.where('square_footage >= ?', query.min_area.to_f)
    end
    unless query.max_area.nil? || query.max_area.empty?
      houses = houses.where('square_footage <= ?', query.max_area.to_f)
    end
    houses = houses.where('style = ?', query.style) unless query.style.nil? || query.style.empty?
    houses
  end
end
