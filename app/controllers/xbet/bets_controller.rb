class Xbet::BetsController < ApplicationController
  before_action :set_xbet_bet, only: [:show, :edit, :update, :destroy]

  # GET /xbet/bets
  # GET /xbet/bets.json
  def index
    @xbet_bets = Xbet::Bet.all
  end

  # GET /xbet/bets/1
  # GET /xbet/bets/1.json
  def show
  end

  # GET /xbet/bets/new
  def new
    @xbet_bet = Xbet::Bet.new
  end

  # GET /xbet/bets/1/edit
  def edit
  end

  # POST /xbet/bets
  # POST /xbet/bets.json
  def create
    @xbet_bet = Xbet::Bet.new(xbet_bet_params)

    respond_to do |format|
      if @xbet_bet.save
        format.html { redirect_to @xbet_bet, notice: 'Bet was successfully created.' }
        format.json { render :show, status: :created, location: @xbet_bet }
      else
        format.html { render :new }
        format.json { render json: @xbet_bet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /xbet/bets/1
  # PATCH/PUT /xbet/bets/1.json
  def update
    respond_to do |format|
      if @xbet_bet.update(xbet_bet_params)
        format.html { redirect_to @xbet_bet, notice: 'Bet was successfully updated.' }
        format.json { render :show, status: :ok, location: @xbet_bet }
      else
        format.html { render :edit }
        format.json { render json: @xbet_bet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /xbet/bets/1
  # DELETE /xbet/bets/1.json
  def destroy
    @xbet_bet.destroy
    respond_to do |format|
      format.html { redirect_to xbet_bets_url, notice: 'Bet was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_xbet_bet
      @xbet_bet = Xbet::Bet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def xbet_bet_params
      params.require(:xbet_bet).permit(:event_id, :bettype_id, :ratio, :active, :dl)
    end
end
