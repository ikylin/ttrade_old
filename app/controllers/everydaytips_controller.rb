class EverydaytipsController < ApplicationController
  before_action :set_everydaytip, only: [:show, :edit, :update, :destroy]

  # GET /everydaytips
  # GET /everydaytips.json
  def index
    @everydaytips = Everydaytip.all
  end

  # GET /everydaytips/1
  # GET /everydaytips/1.json
  def show
  end

  # GET /everydaytips/new
  def new
    @everydaytip = Everydaytip.new
  end

  # GET /everydaytips/1/edit
  def edit
  end

  # POST /everydaytips
  # POST /everydaytips.json
  def create
    @everydaytip = Everydaytip.new(everydaytip_params)

    respond_to do |format|
      if @everydaytip.save
        format.html { redirect_to @everydaytip, notice: 'Everydaytip was successfully created.' }
        format.json { render :show, status: :created, location: @everydaytip }
      else
        format.html { render :new }
        format.json { render json: @everydaytip.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /everydaytips/1
  # PATCH/PUT /everydaytips/1.json
  def update
    respond_to do |format|
      if @everydaytip.update(everydaytip_params)
        format.html { redirect_to @everydaytip, notice: 'Everydaytip was successfully updated.' }
        format.json { render :show, status: :ok, location: @everydaytip }
      else
        format.html { render :edit }
        format.json { render json: @everydaytip.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /everydaytips/1
  # DELETE /everydaytips/1.json
  def destroy
    @everydaytip.destroy
    respond_to do |format|
      format.html { redirect_to everydaytips_url, notice: 'Everydaytip was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_everydaytip
      @everydaytip = Everydaytip.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def everydaytip_params
      params.require(:everydaytip).permit(:tip)
    end
end
