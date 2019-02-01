# frozen_string_literal: true

# Model to represent a Real Estate Company
class RealEstateCompany < ApplicationRecord
  validates :name, :website, :address, :size, :founded,
            :revenue, :synopsis, presence: true
  validates :size, :founded,
            numericality: { only_integer: true, greater_than: 0 }
  validates :revenue, numericality: true
  validates :website, format: {
    with: %r/https?:\/\/?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?/i
  }

  # Relationship
  has_many :realtor, dependent: :restrict_with_error
  has_many :houses, dependent: :delete_all
end
