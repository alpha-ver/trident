class Bet::GroupsController < ApplicationController
  before_action :set_bet_group, only: [:show, :edit, :update, :destroy]

  # GET /bet/groups
  # GET /bet/groups.json
  def index
    @bet_groups = Bet::Group.all
  end

  # GET /bet/groups/1
  # GET /bet/groups/1.json
  def show
  end

  # GET /bet/groups/new
  def new
    @bet_group = Bet::Group.new
  end

  # GET /bet/groups/1/edit
  def edit
  end

  # POST /bet/groups
  # POST /bet/groups.json
  def create
    @bet_group = Bet::Group.new(bet_group_params)

    respond_to do |format|
      if @bet_group.save
        format.html { redirect_to @bet_group, notice: 'Group was successfully created.' }
        format.json { render :show, status: :created, location: @bet_group }
      else
        format.html { render :new }
        format.json { render json: @bet_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bet/groups/1
  # PATCH/PUT /bet/groups/1.json
  def update
    respond_to do |format|
      if @bet_group.update(bet_group_params)
        format.html { redirect_to @bet_group, notice: 'Group was successfully updated.' }
        format.json { render :show, status: :ok, location: @bet_group }
      else
        format.html { render :edit }
        format.json { render json: @bet_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bet/groups/1
  # DELETE /bet/groups/1.json
  def destroy
    @bet_group.destroy
    respond_to do |format|
      format.html { redirect_to bet_groups_url, notice: 'Group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bet_group
      @bet_group = Bet::Group.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bet_group_params
      params.require(:bet_group).permit(:name, :find_names, :created, :api_xbet_id, :api_xbet_params)
    end
end
