# frozen_string_literal: true

# Dashboard view
class WelcomeController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_user_has_project!

  def index

    @amountProcessing = Current.project.receipts.waiting.count
    puts @amountProcessing

    if Current.project.hasProcessedReceipts
      @total = Current.project.receipts.processed.sum(:value_cents) / 100

      all = Current.project.receipts.processed.includes(:category).group('categories.name').sum(:value_cents)
      @pie_chart_data = all.each { |k, v| all[k] = v / 100 }
    elsif Current.project.hasReceiptsButNoneProcessedYet
      @receipts = Current.project.receipts.waiting
      render 'processing'
    else
      render 'tutorial'
    end
  end

  private

    # This should never happen. 
    # Likely something in the auto creation of the first project went wrong
    def ensure_user_has_project!
      if !Current.project
        throw 'No project for this user available. This should never happen.'
      end
    end
end
