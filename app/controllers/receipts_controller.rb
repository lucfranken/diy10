# frozen_string_literal: true

# Handles creation of new receipts and viewing them
class ReceiptsController < ApplicationController
  before_action :authenticate_user!

  def index
    @receipts = current_user.receipts.order('created_at DESC').all.with_attached_images.includes(:supplier)
  end

  def new; end

  def show
    # render plain: current_user.inspect
    @receipt = current_user.receipts.find(params[:id])
  end

  def create
    @receipt = current_user.receipts.new(receipt_params)

    @receipt.save
    redirect_to receipts_path
  end

  private

  def receipt_params
    params.require(:receipt).permit(:value, images: [])
  end
end
