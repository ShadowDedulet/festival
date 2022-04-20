class EventsController < ApplicationController
  before_action :set_event, only: %i[ show update ]
  
  # просмотр наступающих и идущих мероприятий доступен пользователю и администратору
  # просмотр всех мероприятий доступен только администратору (прошедшие и нет)
  def index
    events = Event.not_ended
    events_with_tickets = events.map do |event|
      { name: event.name, 
        date_start: event.date_start, 
        date_end: event.date_end, 
        tickets: SelectTicketsService.new({event_id: event.id}).call }
    end
    render json: events_with_tickets
  end

  # Просматривать определенные билеты может пользователь(только те, которые принадлежат ему) и администратор любые
  def show
    event = Event.find(params[:id])
    render json: event.tickets
  end

  # Создавать мероприятия может только администратор
  def create
    event = Event.new(event_params)
    if event.save
      render json: event, status: :created
    else
      render json: event.errors, status: :unprocessable_entity
    end
  end

  # обновление мероприятия может осуществлять только администратор
  def update
    if @event.update(event_params)
      render json: @event, status: :ok
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  private

  def set_event
    @event = Event.find_by_id(params[:id])
  end

  def event_params
    params.require(:event).permit(:name, :date_start, :date_end)
  end
end
