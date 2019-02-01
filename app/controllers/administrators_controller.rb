# frozen_string_literal: true

# Class to represent realtors actions
class AdministratorsController < ApplicationController
  before_action :authenticate_administrator!

  def index; end

  def show
    render 'index'
  end

  def users
    @users = Realtor.all + Hunter.all
  end
end
