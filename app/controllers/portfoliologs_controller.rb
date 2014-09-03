class PortfoliologsController < ApplicationController
  before_action :set_portfoliolog, only: [:show, :edit, :update, :destroy]

  # GET /portfoliologs
  # GET /portfoliologs.json
  def index
    @portfoliologs = Portfoliolog.all
  end

  # GET /portfoliologs/1
  # GET /portfoliologs/1.json
  def show
  end

  # GET /portfoliologs/new
  def new
    @portfoliolog = Portfoliolog.new
  end

  # GET /portfoliologs/1/edit
  def edit
  end

  # POST /portfoliologs
  # POST /portfoliologs.json
  def create
    @portfoliolog = Portfoliolog.new(portfoliolog_params)

    respond_to do |format|
      if @portfoliolog.save
        format.html { redirect_to @portfoliolog, notice: 'Portfoliolog was successfully created.' }
        format.json { render :show, status: :created, location: @portfoliolog }
      else
        format.html { render :new }
        format.json { render json: @portfoliolog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /portfoliologs/1
  # PATCH/PUT /portfoliologs/1.json
  def update
    respond_to do |format|
      if @portfoliolog.update(portfoliolog_params)
        format.html { redirect_to @portfoliolog, notice: 'Portfoliolog was successfully updated.' }
        format.json { render :show, status: :ok, location: @portfoliolog }
      else
        format.html { render :edit }
        format.json { render json: @portfoliolog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /portfoliologs/1
  # DELETE /portfoliologs/1.json
  def destroy
    @portfoliolog.destroy
    respond_to do |format|
      format.html { redirect_to portfoliologs_url, notice: 'Portfoliolog was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_portfoliolog
      @portfoliolog = Portfoliolog.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def portfoliolog_params
      params.require(:portfoliolog).permit(:opt, :time)
    end
end
