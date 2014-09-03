class ReservesController < ApplicationController
	include ReservesHelper
	include QuotationdatafilesHelper
	before_filter :authenticate_user!, except: [:pubindex]
  before_action :set_reserve, only: [:show, :edit, :update, :destroy]

  # GET /reserves
  # GET /reserves.json
  def index
		case params["qtype"]
		when 'status'
    	@reserves = Reserve.where(marketdate: tradedate, stockstatus: "#{params['status']}").order(plratio: :desc)
		when 'advise'
      if Sysconfig.find_by(cfgname: 'batchname').cfgstring != 'datechange' 
        @reserves = Reserve.where(marketdate: tradedate, optadvise: "#{params['optadvise']}").order(plratio: :desc)
      else 
        @reserves = Reserve.where(marketdate: pretradedate, optadvise: "#{params['optadvise']}").order(plratio: :desc)
      end
		when 'catch'
    	@reserves = Reserve.where(marketdate: tradedate, catchdate: tradedate).order(plratio: :desc)
		when 'yestoday'
    	@reserves = Reserve.daydata(pretradedate).order(plratio: :desc)
		when 'today'
    	@reserves = Reserve.daydata(tradedate).order(plratio: :desc)
		else
    	@reserves = Reserve.order(plratio: :desc)
    	#@reserves = Reserve.where(marketdate: tradedate).order(plratio: :desc)
		end
  end

  def pubindex

    if Sysconfig.find_by(cfgname: 'batchname').cfgstring != 'datechange' 
      @reserves = Reserve.where(marketdate: tradedate, optadvise: 'buy').order(plratio: :desc)
    else 
      @reserves = Reserve.where(marketdate: pretradedate, optadvise: 'buy').order(plratio: :desc)
    end

    respond_to do |format|
      format.html {render :pubindex, layout: 'public'} 
    end

  end
  
  def qcode
      @reserves = []
    	Quotation.where(code: params[:qcode]).order(marketdate: :desc).each do |q|
        @reserves = @reserves + q.reserve
      end
    respond_to do |format|   
      format.html { render :index } 
    end
  end

  # GET /reserves/1
  # GET /reserves/1.json
  def show
  end

  # GET /reserves/new
  def new
    @reserve = Reserve.new
  end

  # GET /reserves/1/edit
  def edit
  end

  # POST /reserves
  # POST /reserves.json
  def create
    @reserve = Reserve.new(reserve_params)

    respond_to do |format|
      if @reserve.save
        format.html { redirect_to @reserve, notice: 'Reserve was successfully created.' }
        format.json { render :show, status: :created, location: @reserve }
      else
        format.html { render :new }
        format.json { render json: @reserve.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reserves/1
  # PATCH/PUT /reserves/1.json
  def update
    respond_to do |format|
      if @reserve.update(reserve_params)
				reserve_update_hhv_llv(@reserve)
        format.html { redirect_to @reserve, notice: 'Reserve was successfully updated.' }
        format.json { render :show, status: :ok, location: @reserve }
      else
        format.html { render :edit }
        format.json { render json: @reserve.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reserves/1
  # DELETE /reserves/1.json
  def destroy
    @reserve.destroy
    respond_to do |format|
      format.html { redirect_to reserves_url, notice: 'Reserve was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reserve
      @reserve = Reserve.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reserve_params
      params.require(:reserve).permit(:marketdate, :stockstatus, :hhv, :llv, :hdate, :ldate, :profit, :loss, :plratio, :optadvise, :note)
    end
		
end
