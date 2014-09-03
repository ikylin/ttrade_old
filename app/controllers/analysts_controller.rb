class AnalystsController < ApplicationController
  before_action :set_analyst, only: [:show, :edit, :update, :destroy]

  # GET /analysts
  # GET /analysts.json
  def index
    @analysts = Analyst.all
  end

  # GET /analysts/1
  # GET /analysts/1.json
  def show
  end

  # GET /analysts/new
  def new
    @analyst = Analyst.new
  end

  # GET /analysts/1/edit
  def edit
  end

  # POST /analysts
  # POST /analysts.json
  def create
    @analyst = Analyst.new(analyst_params)

    respond_to do |format|
      if @analyst.save
        format.html { redirect_to @analyst, notice: 'Analyst was successfully created.' }
        format.json { render :show, status: :created, location: @analyst }
      else
        format.html { render :new }
        format.json { render json: @analyst.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /analysts/1
  # PATCH/PUT /analysts/1.json
  def update
    respond_to do |format|
      if @analyst.update(analyst_params)
        format.html { redirect_to @analyst, notice: 'Analyst was successfully updated.' }
        format.json { render :show, status: :ok, location: @analyst }
      else
        format.html { render :edit }
        format.json { render json: @analyst.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /analysts/1
  # DELETE /analysts/1.json
  def destroy
    @analyst.destroy
    respond_to do |format|
      format.html { redirect_to analysts_url, notice: 'Analyst was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_analyst
      @analyst = Analyst.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def analyst_params
      params.require(:analyst).permit(:name, :lvl, :fan)
    end
end
