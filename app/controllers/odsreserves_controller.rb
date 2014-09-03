class OdsreservesController < ApplicationController
  before_action :set_odsreserf, only: [:show, :edit, :update, :destroy]

  # GET /odsreserves
  # GET /odsreserves.json
  def index
    @odsreserves = Odsreserf.all
  end

  # GET /odsreserves/1
  # GET /odsreserves/1.json
  def show
  end

  # GET /odsreserves/new
  def new
    @odsreserf = Odsreserf.new
  end

  # GET /odsreserves/1/edit
  def edit
  end

  # POST /odsreserves
  # POST /odsreserves.json
  def create
    @odsreserf = Odsreserf.new(odsreserf_params)

    respond_to do |format|
      if @odsreserf.save
        format.html { redirect_to @odsreserf, notice: 'Odsreserf was successfully created.' }
        format.json { render :show, status: :created, location: @odsreserf }
      else
        format.html { render :new }
        format.json { render json: @odsreserf.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /odsreserves/1
  # PATCH/PUT /odsreserves/1.json
  def update
    respond_to do |format|
      if @odsreserf.update(odsreserf_params)
        format.html { redirect_to @odsreserf, notice: 'Odsreserf was successfully updated.' }
        format.json { render :show, status: :ok, location: @odsreserf }
      else
        format.html { render :edit }
        format.json { render json: @odsreserf.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /odsreserves/1
  # DELETE /odsreserves/1.json
  def destroy
    @odsreserf.destroy
    respond_to do |format|
      format.html { redirect_to odsreserves_url, notice: 'Odsreserf was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_odsreserf
      @odsreserf = Odsreserf.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def odsreserf_params
      params.require(:odsreserf).permit(:code, :name, :plate, :open, :high, :low, :close, :dprofit, :duration)
    end
end
