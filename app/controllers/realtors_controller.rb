# frozen_string_literal: true

# Controller to represent realtors actions
class RealtorsController < ApplicationController
  before_action :authenticate_realtor!

  def index; end

  def show
    render 'index'
  end
end
