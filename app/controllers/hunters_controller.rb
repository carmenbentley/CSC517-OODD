# frozen_string_literal: true

# Class to represent hunter's actions
class HuntersController < ApplicationController
  before_action :authenticate_hunter!

  def index; end

  def show
    render 'index'
  end

  def wishlist
    @wishlist = current_hunter.houses
  end
end
