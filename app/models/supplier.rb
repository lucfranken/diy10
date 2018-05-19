# frozen_string_literal: true

# The company which sent the receipt
class Supplier < ApplicationRecord
  has_many :receipt
end
