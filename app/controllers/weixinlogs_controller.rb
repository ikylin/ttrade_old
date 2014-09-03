class WeixinlogsController < ApplicationController
  before_action :set_weixinlog, only: [:show, :edit, :update, :destroy]

  # GET /weixinlogs
  # GET /weixinlogs.json
  def index
    @weixinlogs = Weixinlog.all
  end

  # GET /weixinlogs/1
  # GET /weixinlogs/1.json
  def show
  end

  # GET /weixinlogs/new
  def new
    @weixinlog = Weixinlog.new
  end

  # GET /weixinlogs/1/edit
  def edit
  end

  # POST /weixinlogs
  # POST /weixinlogs.json
  def create
    @weixinlog = Weixinlog.new(weixinlog_params)

    respond_to do |format|
      if @weixinlog.save
        format.html { redirect_to @weixinlog, notice: 'Weixinlog was successfully created.' }
        format.json { render :show, status: :created, location: @weixinlog }
      else
        format.html { render :new }
        format.json { render json: @weixinlog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /weixinlogs/1
  # PATCH/PUT /weixinlogs/1.json
  def update
    respond_to do |format|
      if @weixinlog.update(weixinlog_params)
        format.html { redirect_to @weixinlog, notice: 'Weixinlog was successfully updated.' }
        format.json { render :show, status: :ok, location: @weixinlog }
      else
        format.html { render :edit }
        format.json { render json: @weixinlog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /weixinlogs/1
  # DELETE /weixinlogs/1.json
  def destroy
    @weixinlog.destroy
    respond_to do |format|
      format.html { redirect_to weixinlogs_url, notice: 'Weixinlog was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_weixinlog
      @weixinlog = Weixinlog.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def weixinlog_params
      params.require(:weixinlog).permit(:time, :content)
    end
end
