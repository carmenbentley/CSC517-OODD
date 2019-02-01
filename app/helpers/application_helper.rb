# frozen_string_literal: true

# Appliocation wide helpers
module ApplicationHelper
  UNAUTHORIZED_FLASH = {
    notice: 'You are not authorized to perform this action',
    class: 'alert alert-danger'
  }.freeze

  def current_user
    current_administrator || current_realtor || current_hunter
  end
end
