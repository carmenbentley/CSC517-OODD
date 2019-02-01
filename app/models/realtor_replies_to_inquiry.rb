# frozen_string_literal: true

class RealtorRepliesToInquiry < ApplicationRecord
  belongs_to :realtor
  belongs_to :inquiry
end
