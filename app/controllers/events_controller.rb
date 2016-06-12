class EventsController < ApplicationController
  before_action :set_event, only: [:edit, :update, :destroy]

  def index
    @events = Event.from_team(current_user.team).order(:start_date, :start_time)
    respond_with(@events)
  end

  def new
    @event = Event.new
    respond_with(@event)
  end

  def edit
  end

  def create
    @event = Event.new(event_params)
    @event.team = current_user.team

    @event.save
    respond_with(@event, location: events_path)
  end

  def update
    @event.update(event_params)
    respond_with(@event, location: events_path)
  end

  def destroy
    @event.destroy
    respond_with(@event)
  end

  private
    def set_event
      @event = Event.find(params[:id])
    end

    def event_params
      params.require(:event).permit(:name, :local, :price, :site, :subject, :start_date, :start_time, :end_date, :end_time)
    end
end
