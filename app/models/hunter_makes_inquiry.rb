# frozen_string_literal: true

class HunterMakesInquiry < ApplicationRecord
  belongs_to :hunter
  belongs_to :inquiry
end
