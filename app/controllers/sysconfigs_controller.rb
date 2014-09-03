class SysconfigsController < ApplicationController
	before_filter :authenticate_user!
  before_action :set_sysconfig, only: [:show, :edit, :update, :destroy]

  # GET /sysconfigs
  # GET /sysconfigs.json
  def index
    @sysconfigs = Sysconfig.all
  end

  # GET /sysconfigs/1
  # GET /sysconfigs/1.json
  def show
  end

  # GET /sysconfigs/new
  def new
    @sysconfig = Sysconfig.new
  end

  # GET /sysconfigs/1/edit
  def edit
  end

  # POST /sysconfigs
  # POST /sysconfigs.json
  def create
    @sysconfig = Sysconfig.new(sysconfig_params)

    respond_to do |format|
      if @sysconfig.save
        format.html { redirect_to @sysconfig, notice: 'Sysconfig was successfully created.' }
        format.json { render :show, status: :created, location: @sysconfig }
      else
        format.html { render :new }
        format.json { render json: @sysconfig.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sysconfigs/1
  # PATCH/PUT /sysconfigs/1.json
  def update
    respond_to do |format|
      if @sysconfig.update(sysconfig_params)
        format.html { redirect_to @sysconfig, notice: 'Sysconfig was successfully updated.' }
        format.json { render :show, status: :ok, location: @sysconfig }
      else
        format.html { render :edit }
        format.json { render json: @sysconfig.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sysconfigs/1
  # DELETE /sysconfigs/1.json
  def destroy
    @sysconfig.destroy
    respond_to do |format|
      format.html { redirect_to sysconfigs_url, notice: 'Sysconfig was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sysconfig
      @sysconfig = Sysconfig.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sysconfig_params
      params.require(:sysconfig).permit(:cfgname, :cfginteger, :cfgdate, :cfgtime, :cfgstring, :cfgtext)
    end
end
