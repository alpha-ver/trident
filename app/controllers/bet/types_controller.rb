class Bet::TypesController < ApplicationController
  before_action :set_bet_type, only: [:show, :edit, :update, :destroy]

  # GET /bet/types
  # GET /bet/types.json
  def index
    @bet_types = Bet::Type.all
  end

  # GET /bet/types/1
  # GET /bet/types/1.json
  def show
  end

  # GET /bet/types/new
  def new
    @bet_type = Bet::Type.new
  end

  # GET /bet/types/1/edit
  def edit
  end

  # POST /bet/types
  # POST /bet/types.json
  def create
    @bet_type = Bet::Type.new(bet_type_params)

    respond_to do |format|
      if @bet_type.save
        format.html { redirect_to @bet_type, notice: 'Type was successfully created.' }
        format.json { render :show, status: :created, location: @bet_type }
      else
        format.html { render :new }
        format.json { render json: @bet_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bet/types/1
  # PATCH/PUT /bet/types/1.json
  def update
    respond_to do |format|
      if @bet_type.update(bet_type_params)
        format.html { redirect_to @bet_type, notice: 'Type was successfully updated.' }
        format.json { render :show, status: :ok, location: @bet_type }
      else
        format.html { render :edit }
        format.json { render json: @bet_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bet/types/1
  # DELETE /bet/types/1.json
  def destroy
    @bet_type.destroy
    respond_to do |format|
      format.html { redirect_to bet_types_url, notice: 'Type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bet_type
      @bet_type = Bet::Type.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bet_type_params
      params.require(:bet_type).permit(:group_id, :name, :find_names, :created, :api_xbet_id, :api_xbet_params)
    end
end
