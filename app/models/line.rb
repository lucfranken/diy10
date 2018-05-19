# frozen_string_literal: true

# A single line on the physical/mail receipt (so not split up yet)
# Contains: amount, description, price, total etc.
class Line < ApplicationRecord
  belongs_to :receipt

  monetize :price_cents, :price_total_cents
end
