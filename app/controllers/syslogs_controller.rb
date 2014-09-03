class SyslogsController < ApplicationController
  before_action :set_syslog, only: [:show, :edit, :update, :destroy]

  # GET /syslogs
  # GET /syslogs.json
  def index
    @syslogs = Syslog.all
  end

  # GET /syslogs/1
  # GET /syslogs/1.json
  def show
  end

  # GET /syslogs/new
  def new
    @syslog = Syslog.new
  end

  # GET /syslogs/1/edit
  def edit
  end

  # POST /syslogs
  # POST /syslogs.json
  def create
    @syslog = Syslog.new(syslog_params)

    respond_to do |format|
      if @syslog.save
        format.html { redirect_to @syslog, notice: 'Syslog was successfully created.' }
        format.json { render :show, status: :created, location: @syslog }
      else
        format.html { render :new }
        format.json { render json: @syslog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /syslogs/1
  # PATCH/PUT /syslogs/1.json
  def update
    respond_to do |format|
      if @syslog.update(syslog_params)
        format.html { redirect_to @syslog, notice: 'Syslog was successfully updated.' }
        format.json { render :show, status: :ok, location: @syslog }
      else
        format.html { render :edit }
        format.json { render json: @syslog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /syslogs/1
  # DELETE /syslogs/1.json
  def destroy
    @syslog.destroy
    respond_to do |format|
      format.html { redirect_to syslogs_url, notice: 'Syslog was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_syslog
      @syslog = Syslog.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def syslog_params
      params.require(:syslog).permit(:role, :time, :opt, :curstate)
    end
end
