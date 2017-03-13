class Xbet::EventsController < ApplicationController
  before_action :set_xbet_event, only: [:show, :edit, :update, :destroy]

  # GET /xbet/events
  # GET /xbet/events.json
  def index
    @xbet_events = Xbet::Event.all
  end

  # GET /xbet/events/1
  # GET /xbet/events/1.json
  def show
  end

  # GET /xbet/events/new
  def new
    @xbet_event = Xbet::Event.new
  end

  # GET /xbet/events/1/edit
  def edit
  end

  # POST /xbet/events
  # POST /xbet/events.json
  def create
    @xbet_event = Xbet::Event.new(xbet_event_params)

    respond_to do |format|
      if @xbet_event.save
        format.html { redirect_to @xbet_event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @xbet_event }
      else
        format.html { render :new }
        format.json { render json: @xbet_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /xbet/events/1
  # PATCH/PUT /xbet/events/1.json
  def update
    respond_to do |format|
      if @xbet_event.update(xbet_event_params)
        format.html { redirect_to @xbet_event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @xbet_event }
      else
        format.html { render :edit }
        format.json { render json: @xbet_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /xbet/events/1
  # DELETE /xbet/events/1.json
  def destroy
    @xbet_event.destroy
    respond_to do |format|
      format.html { redirect_to xbet_events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_xbet_event
      @xbet_event = Xbet::Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def xbet_event_params
      params.require(:xbet_event).permit(:sport_id, :host_command_id, :slave_command_id, :commands_ids, :status, :score_history, :message_history, :dl, :start_at)
    end
end
