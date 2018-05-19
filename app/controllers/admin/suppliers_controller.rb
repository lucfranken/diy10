# frozen_string_literal: true

module Admin
  # Basic management for suppliers
  class SuppliersController < AdminController
    before_action :set_supplier, only: %i[show edit update destroy]

    def index
      @suppliers = Supplier.all
    end

    def show; end

    def new
      @supplier = Supplier.new
    end

    def edit; end

    def create
      @supplier = Supplier.new(supplier_params)

      respond_to do |format|
        if @supplier.save
          format.html { redirect_to [:admin, @supplier], notice: 'Supplier was successfully created.' }
          format.json { render :show, status: :created, location: @supplier }
        else
          format.html { render :new }
          format.json { render json: @supplier.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      respond_to do |format|
        if @supplier.update(supplier_params)
          format.html { redirect_to [:admin, @supplier], notice: 'Supplier was successfully updated.' }
          format.json { render :show, status: :ok, location: @supplier }
        else
          format.html { render :edit }
          format.json { render json: @supplier.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @supplier.destroy
      respond_to do |format|
        format.html { redirect_to uppliers_url, notice: 'Supplier was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_supplier
      @supplier = Supplier.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def supplier_params
      params.require(:supplier).permit(:name)
    end
  end
end
