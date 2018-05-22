# frozen_string_literal: true

module Admin
  # Handles the processing of receipts internally
  class ReceiptsController < AdminController
    def index
      @receipts = Receipt.order('created_at ASC').waiting.with_attached_images
    end

    def edit
      @receipt = Receipt.find(params[:id])
      20.times { @receipt.lines.build }
    end

    def update
      @receipt = Receipt.find(params[:id])

      receipt_params_modified = receipt_params

      # receipt_params_modified[:status] = :processed

      if @receipt.update(receipt_params_modified)
        redirect_to admin_receipts_path
      else
        render 'edit'
      end
    end

    private

    def receipt_params
      params.require(:receipt).permit(:value,
                                      :supplier_id,
                                      :category_id,
                                      :status,
                                      images: [],
                                      lines_attributes: %i[
                                        id
                                        amount
                                        description
                                        price
                                        price_total
                                      ])
    end
  end
end
