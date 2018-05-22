# frozen_string_literal: true

# Dashboard view
class WelcomeController < ApplicationController
  before_action :authenticate_user!

  def index

    if current_user.hasProcessedReceipts
      @total = current_user.receipts.processed.sum(:value_cents) / 100

      all = current_user.receipts.processed.includes(:category).group('categories.name').sum(:value_cents)
      @pie_chart_data = all.each { |k, v| all[k] = v / 100 }
    elsif current_user.hasReceiptsButNoneProcessedYet
      @amountProcessing = current_user.receipts.waiting.count
      render 'processing'
    else
      render 'tutorial'
    end
  end
end
