# frozen_string_literal: true

# Helpers for Realtor's Controller
module RealtorsHelper
  def authz_user
    # TODO: Also allow admins here
    current_realtor
  end
end
