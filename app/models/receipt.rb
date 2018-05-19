# frozen_string_literal: true

# Main receipt class which groups all data related to one physical/mail receipt
class Receipt < ApplicationRecord
  belongs_to :user
  belongs_to :supplier, optional: true
  belongs_to :category, optional: true

  has_many :lines

  accepts_nested_attributes_for :lines,
                                allow_destroy: true,
                                reject_if: lambda { |attributes|
                                  attributes['description'].blank?
                                }

  monetize :value_cents

  has_many_attached :images

  enum status: {
    waiting: 0,
    processed: 1
  }
end
