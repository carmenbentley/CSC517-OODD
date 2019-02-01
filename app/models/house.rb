# frozen_string_literal: true

# Model for a House
class House < ApplicationRecord
  @@styles = ['Single-Family',
              'Multi-Family',
              'Paired-Home',
              'Apartment',
              'Condo',
              'Townhome',
              'Manufactured']

  def self.styles
    @@styles
  end

  validates :location, :square_footage, :year_built, :style, :list_price, :num_floors,
            :owner, :real_estate_company, :realtor, presence: true
  validates :square_footage, :year_built, numericality: { greater_than_or_equal_to: 0 }
  validates :owner, format: { with: /\A[a-zA-Z ]+\z/, message: 'allows only letters and spaces' }
  validates :style, inclusion: { in: styles, message: '%{value} is not a valid style' }
  validates :basement, inclusion: { in: [true, false] }

  has_many :inquiry, dependent: :delete_all
  belongs_to :real_estate_company
  belongs_to :realtor
  has_and_belongs_to_many :hunters

  has_one_attached :photo

  before_destroy { |r| r.photo.purge }
end
