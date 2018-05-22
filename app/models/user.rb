# frozen_string_literal: true

# User, handled by devine
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :receipts, dependent: :destroy

  enum role: {
    user: 0,
    admin: 1
  }

  after_initialize :set_default_role, if: :new_record?

  def set_default_role
    self.role ||= :user
  end

  # Has any receipt at all
  def hasReceipts
    Current.user.receipts.all.any?
  end

  # Has uploaded a receipt but we are not ready with processing
  def hasReceiptsButNoneProcessedYet
    hasReceipts && !hasProcessedReceipts
  end

  # At least one is processed
  def hasProcessedReceipts
    Current.user.receipts.processed.any?
  end
end
