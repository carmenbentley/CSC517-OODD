# frozen_string_literal: true

module Accessible
  extend ActiveSupport::Concern
  included do
    before_action :check_user
  end

  protected

  def check_user
    if current_administrator
      flash.clear
      redirect_to(administrators_path) && return
    elsif current_realtor
      flash.clear
      redirect_to(realtors_path) && return
    elsif current_hunter
      flash.clear
      redirect_to(hunters_path) && return
    end
  end
end
