class ChampsController < ApplicationController
  before_action :set_champ, only: [:show, :edit, :destroy]

  # GET /champs
  # GET /champs.json
  def index
    @champs = Champ.all
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
    if params[:id] == "linked" && params[:champ][:id].count == 2
      champs = Champ.where(:id => params[:champ][:id])

      if champs[1].created    == "api_leon"
        champs[0].api_leon_id     = champs[1].api_leon_id
        champs[0].api_leon_params = champs[1].api_leon_params
      elsif champs[1].created == "api_xbet"
        champs[0].api_xbet_id     = champs[1].api_xbet_id
        champs[0].api_xbet_params = champs[1].api_xbet_params
      elsif champs[1].created == "merged"

      end

      champs[0].find_names += champs[1].find_names
      champs[0].created = "merged|leon,xbet"
      champs[0].save

      champs[1].all_bet_events.each do |events|
        events.each do |event|
          event.champ_id = champs[0].id
          event.save
        end
      end

      champs[1].delete

      champs = Champ.where(:id => params[:champ][:id])

      respond_to do |format|
        if 1==1
          #format.html { redirect_to @champ, notice: 'Champ was successfully updated.' }
          format.json { render json: champs,  status: :ok }
        else
          #format.html { render :edit }
          format.json { render json: @champ.errors, status: :unprocessable_entity }
        end
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
      params.require(:champ).permit(:name, :find_names, :created, :sport_id, :api_xbet_id, :api_xbet_params)
    end
end
