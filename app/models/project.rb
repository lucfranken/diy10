class Project < ApplicationRecord
  belongs_to :user
  has_many :receipts
  validates :name, :presence => true

  # Has any receipt at all
  def hasReceipts
    self.receipts.all.any?
  end

  # Has uploaded a receipt but we are not ready with processing
  def hasReceiptsButNoneProcessedYet
    hasReceipts && !hasProcessedReceipts
  end

  # At least one is processed
  def hasProcessedReceipts
    self.receipts.processed.any?
  end

end
