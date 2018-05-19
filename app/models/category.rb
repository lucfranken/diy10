# frozen_string_literal: true

# The general categories
class Category < ApplicationRecord
  has_many :receipt
end
