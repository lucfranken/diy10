# frozen_string_literal: true

# Default abstract to inherit from for ActiveRecord
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
