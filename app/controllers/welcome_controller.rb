# frozen_string_literal: true

# Dashboard view
class WelcomeController < ApplicationController
  before_action :authenticate_user!

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
end
