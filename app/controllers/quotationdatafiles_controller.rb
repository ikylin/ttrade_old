class QuotationdatafilesController < ApplicationController
	include QuotationdatafilesHelper
	before_filter :authenticate_user!
  before_action :set_quotationdatafile, only: [:show, :edit, :update, :destroy]

  # GET /quotationdatafiles
  # GET /quotationdatafiles.json
  def index
    @quotationdatafiles = Quotationdatafile.order(created_at: :desc)
  end

  # GET /quotationdatafiles/1
  # GET /quotationdatafiles/1.json
  def show
  end

  # GET /quotationdatafiles/1/doupdate
  def doupdate 
		@quotationdatafile = Quotationdatafile.find(params[:id])	

		case @quotationdatafile.filetype
		when 'md'
			ActiveRecord::Base.transaction do
				marketdatefileprocess(@quotationdatafile.avatar.path)
			end
			flash[:notice] = "market data file input successfully."
			respond_to do |format|
  	 		format.html { redirect_to :marketdates }
			end
		when 'hq'
#			if Time.now.strftime("%y-%m-%d") == sysmarketdate.strftime("%y-%m-%d")
					if config_get('batchname') == 'datechange' and config_get('batchstatus') == 0
						ActiveRecord::Base.transaction do
							config_set 'batchstatus', 1

							quotationfileprocess(@quotationdatafile.avatar.path)
							updateReserves
							updatePortfolios
							updateAccounts

							config_set 'batchname', 'quotation'
							config_set 'batchstatus', 0 
						end
					end
#				end
		  flash[:notice] = "quotation data file inputed and day changed successfully."
			respond_to do |format|
  	 		format.html { redirect_to quotations_path(qtype: 'today') }
  	 		#format.html { redirect_to :quotations }
			end
			when 'ods'
#			if Time.now.strftime("%y-%m-%d") == sysmarketdate.strftime("%y-%m-%d")
						ActiveRecord::Base.transaction do
							odsreservefileprocess(@quotationdatafile.avatar.path)
              cleandatatotoday
						end
#				end
		  flash[:notice] = "ods reserves data file inputed and day changed successfully."
			respond_to do |format|
  	 		format.html { redirect_to odsreserves_path() }
  	 		#format.html { redirect_to :quotations }
			end
		when 'bxc'
        if current_user.analyst.nil?
		      flash[:notice] = "You are not analyst."
        else
#				if Time.now.strftime("%y-%m-%d") == sysmarketdate.strftime("%y-%m-%d")
					if config_get('batchname') == 'quotation' and config_get('batchstatus') == 0
						ActiveRecord::Base.transaction do
							config_set 'batchstatus', 1

							reservefileprocess(@quotationdatafile.avatar.path)
							config_set 'batchname', 'reserve'
							config_set 'batchstatus', 0 
						end
					end
#				end
		    flash[:notice] = "reserv data file input successfully."
      end
			respond_to do |format|
  	 		format.html { redirect_to reserves_path(qtype: 'catch') }
			end
		else

		end
	end

  def bxctoodsupdate
		@quotationdatafile = Quotationdatafile.find(params[:id])	
#	    if Time.now.strftime("%y-%m-%d") == sysmarketdate.strftime("%y-%m-%d")
						ActiveRecord::Base.transaction do
							odsreservefileprocess(@quotationdatafile.avatar.path)
              cleandatatotoday
						end
#				end
		  flash[:notice] = "ods reserves data file inputed and day changed successfully."
			respond_to do |format|
  	 		format.html { redirect_to odsreserves_path() }
  	 		#format.html { redirect_to :quotations }
			end
		
  end

	def dobatch
		
		case params[:battype]
		when 'riqie'
#			job_id =
#      Rufus::Scheduler.singleton.in '5s' do
        Rails.logger.info ">>>>>>>>>>>>>>>time flies, it's now #{Time.now}"

#				if Time.now.strftime("%y-%m-%d") == sysmarketdate.strftime("%y-%m-%d")
					if config_get('batchname') == 'reserve' and config_get('batchstatus') == 0
						ActiveRecord::Base.transaction do
							config_set 'batchstatus', 1
							doadvise
							marketdatechange
              dataclean
							config_set 'batchname', 'datechange'
							config_set 'batchstatus', 0 
						end
					end
#				end

#      end
		  #flash[:notice] = "doadvise successfully. #{job_id}"
			respond_to do |format|
  	 		format.html { redirect_to :sysconfigs }
			end
		when 'guanzhu'
			ActiveRecord::Base.transaction do
				guanzhu
			end
		  flash[:notice] = "guanzhu successfully."
			respond_to do |format|
  	 		format.html { redirect_to :quotationdatafiles }
			end
		when 'gensui'
			ActiveRecord::Base.transaction do
			 	gensui	
			end
		  flash[:notice] = "gensui successfully."
			respond_to do |format|
  	 		format.html { redirect_to :quotationdatafiles }
			end
		when 'zhanghu'
			ActiveRecord::Base.transaction do
				createAccount	
			end
		  flash[:notice] = "zhanghu successfully."
			respond_to do |format|
  	 		format.html { redirect_to :quotationdatafiles }
			end
		when 'jiangu'
			ActiveRecord::Base.transaction do
				jiangu	
			end
		  flash[:notice] = "jiangu successfully."
			respond_to do |format|
  	 		format.html { redirect_to :quotationdatafiles }
			end
    when 'all'
      flash[:notice] = allportfolios
			respond_to do |format|
  	 		format.html { redirect_to :reserves }
			end

		when 'shouyi'
			ActiveRecord::Base.transaction do
				shouyi	
			end
		  flash[:notice] = "shouyi successfully."
			respond_to do |format|
  	 		format.html { redirect_to :quotationdatafiles }
			end
		else
		  flash[:notice] = "nothing do ."
			respond_to do |format|
  	 		format.html { redirect_to :quotationdatafiles }
			end

		end  
  end

  # GET /quotationdatafiles/new
  def new
    @quotationdatafile = Quotationdatafile.new
		@quotationdatafile.marketdate = tradedate

		case params[:battype]
		when 'q'
			@quotationdatafile.filetype = 'hq'
			session[:opttype] = 'quick'
		when 'b'
			@quotationdatafile.filetype = 'bxc'
			session[:opttype] = 'quick'
		when 'r'
			@quotationdatafile.filetype = 'rq'
			session[:opttype] = 'quick'
		when 'o'
			@quotationdatafile.filetype = 'ods'
			session[:opttype] = 'quick'
		else
		
		end	
  end

  # GET /quotationdatafiles/1/edit
  def edit
  end

  # POST /quotationdatafiles
  # POST /quotationdatafiles.json
  def create
    @quotationdatafile = Quotationdatafile.new(quotationdatafile_params)
		@quotationdatafile.marketdate = tradedate

    respond_to do |format|
      if @quotationdatafile.save
				if session[:opttype] == 'quick'
					format.html {	redirect_to doupdate_quotationdatafile_path(@quotationdatafile) }
				else
        	format.html { redirect_to :quotationdatafiles }
				end
        #format.html { redirect_to @quotationdatafile, notice: 'Quotationdatafile was successfully created.' }
        #format.json { render :show, status: :created, location: @quotationdatafile }
      else
        format.html { render :new }
        format.json { render json: @quotationdatafile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /quotationdatafiles/1
  # PATCH/PUT /quotationdatafiles/1.json
  def update
    respond_to do |format|
      if @quotationdatafile.update(quotationdatafile_params)
        format.html { redirect_to @quotationdatafile, notice: 'Quotationdatafile was successfully updated.' }
        format.json { render :show, status: :ok, location: @quotationdatafile }
      else
        format.html { render :edit }
        format.json { render json: @quotationdatafile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quotationdatafiles/1
  # DELETE /quotationdatafiles/1.json
  def destroy
    @quotationdatafile.destroy
    respond_to do |format|
      format.html { redirect_to quotationdatafiles_url, notice: 'Quotationdatafile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
	
	#Paperclip.interpolates :filetype do |attachment, style|
	#	attachment.instance.filetype 
	#end

	#Paperclip.interpolates :marketdate do |attachment, style|
	#	attachment.instance.marketdate
	#end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quotationdatafile
      @quotationdatafile = Quotationdatafile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def quotationdatafile_params
      params.require(:quotationdatafile).permit(:marketdate, :filetype, :filestatus, :avatar)
    end
end
