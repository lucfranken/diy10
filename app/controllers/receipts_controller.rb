# frozen_string_literal: true

# Handles creation of new receipts and viewing them
class ReceiptsController < ApplicationController
  before_action :authenticate_user!

  def index
    @receipts = Current.project.receipts.order('created_at DESC').processed.with_attached_images.includes(:supplier)
  end

  def new; end

  def show
    # render plain: current_user.inspect
    @receipt = Current.project.receipts.find(params[:id])
  end

  def create
    # Send before saving so we know someone is trying to send something 
    AdminMailer.receipt_email.deliver_now

    @receipt = Current.project.receipts.new(receipt_params)

    @receipt.save!
    redirect_to root_path
  end

  private

  def receipt_params
    params.require(:receipt).permit(:q, :value, images: [])
  end
end
