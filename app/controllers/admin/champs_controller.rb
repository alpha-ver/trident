class Admin::ChampsController < ApplicationController
  before_action :set_champ, only: [:show, :edit, :update, :destroy]

  # GET /champs
  # GET /champs.json
  def index
    @sport_form  = Sport.linked
    ap params

    if !champ_params.nil? && !champ_params[:sport_id].nil?
      @current_sport = Sport.find(champ_params[:sport_id])
      @champs_xbet   = @current_sport.champs.not_xbets
      @champs_leon   = @current_sport.champs.not_leons
    else
      @current_sport = Sport.first
      @champs_xbet   = @current_sport.champs.not_xbets
      @champs_leon   = @current_sport.champs.not_leons
    end
  end

  # GET /champs/1
  # GET /champs/1.json
  def show
  end

  # GET /champs/new
  def new
    @champ = Champ.new
  end

  # GET /champs/1/edit
  def edit
  end

  # POST /champs
  # POST /champs.json
  def create
    @champ = Champ.new(champ_params)

    respond_to do |format|
      if @champ.save
        format.html { redirect_to @champ, notice: 'Champ was successfully created.' }
        format.json { render :show, status: :created, location: @champ }
      else
        format.html { render :new }
        format.json { render json: @champ.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /champs/1
  # PATCH/PUT /champs/1.json
  def update
    respond_to do |format|
      if @champ.update(champ_params)
        format.html { redirect_to @champ, notice: 'Champ was successfully updated.' }
        format.json { render :show, status: :ok, location: @champ }
      else
        format.html { render :edit }
        format.json { render json: @champ.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /champs/1
  # DELETE /champs/1.json
  def destroy
    @champ.destroy
    respond_to do |format|
      format.html { redirect_to champs_url, notice: 'Champ was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_champ
      @champ = Champ.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def champ_params
      if !params[:champ].nil?
        params.require(:champ).permit(:name, :find_names, :created, :sport_id, :api_xbet_id, :api_xbet_params)
      else
      end
    end
end
