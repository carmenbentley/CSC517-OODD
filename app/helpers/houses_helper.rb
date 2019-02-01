# frozen_string_literal: true

module HousesHelper
  # Object to represent the search's form
  class FormObject
    include ActiveModel::Model

    attr_accessor :location, :min_price, :max_price, :min_area,
                  :max_area, :style

    def self.model_name
      ActiveModel::Name.new(self, nil, 'search')
    end
  end
end
