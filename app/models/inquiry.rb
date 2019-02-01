# frozen_string_literal: true

# Model for an inquiry
class Inquiry < ApplicationRecord
  validates :subject, :message, :house, :hunter, presence: true
  validates :subject, :message, length: { minimum: 1 }

  belongs_to :house
  belongs_to :hunter
  belongs_to :realtor, optional: true
end
