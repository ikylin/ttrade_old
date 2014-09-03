class MarketdatesController < ApplicationController
  before_action :set_marketdate, only: [:show, :edit, :update, :destroy]

  # GET /marketdates
  # GET /marketdates.json
  def index
    @marketdates = Marketdate.all
  end
	
	def reset_marketdate_to_today
		ActiveRecord::Base.transaction do
			md = Sysconfig.find_by(cfgname: 'marketdate').cfgdate
			Marketdate.where("tradedate < ?", md).update_all(daystate: 'past')
			#Marketdate.where("tradedate < ?", "#{Time.new.strftime("%Y-%m-%d")}").update_all(daystate: 'past')
			Marketdate.where("tradedate >= ?", md).update_all(daystate: '')
			#Marketdate.where("tradedate >= ?", "#{Time.new.strftime("%Y-%m-%d")}").update_all(daystate: '')
			#Sysconfig.find_by(cfgname: 'marketdate').update!(cfgdate: Time.new)
			Sysconfig.find_by(cfgname: 'batchname').update!(cfgstring: 'datechange')
			Sysconfig.find_by(cfgname: 'batchstatus').update!(cfginteger: 0)
		end
		redirect_to reserves_path
	end

  # GET /marketdates/1
  # GET /marketdates/1.json
  def show
  end

  # GET /marketdates/new
  def new
    @marketdate = Marketdate.new
  end

  # GET /marketdates/1/edit
  def edit
  end

  # POST /marketdates
  # POST /marketdates.json
  def create
    @marketdate = Marketdate.new(marketdate_params)

    respond_to do |format|
      if @marketdate.save
        format.html { redirect_to @marketdate, notice: 'Marketdate was successfully created.' }
        format.json { render :show, status: :created, location: @marketdate }
      else
        format.html { render :new }
        format.json { render json: @marketdate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /marketdates/1
  # PATCH/PUT /marketdates/1.json
  def update
    respond_to do |format|
      if @marketdate.update(marketdate_params)
        format.html { redirect_to @marketdate, notice: 'Marketdate was successfully updated.' }
        format.json { render :show, status: :ok, location: @marketdate }
      else
        format.html { render :edit }
        format.json { render json: @marketdate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /marketdates/1
  # DELETE /marketdates/1.json
  def destroy
    @marketdate.destroy
    respond_to do |format|
      format.html { redirect_to marketdates_url, notice: 'Marketdate was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_marketdate
      @marketdate = Marketdate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def marketdate_params
      params.require(:marketdate).permit(:tradedate, :daystate)
    end
end
