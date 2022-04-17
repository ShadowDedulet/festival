class Api::EventsController < ApplicationController
  before_action :set_event, only: %i[ show update ]
  
  # просмотр наступающих и идущих мероприятий доступен пользователю и администратору
  # просмотр всех мероприятий доступен только администратору (прошедшие и нет)
  def index
    event = (params[:role] == 'admin' && params[:all]) ? Event.all : Event.not_ended
    render json: event, status: :ok
  end

  # Просматривать определенные билеты может пользователь(только те, которые принадлежат ему) и администратор любые
  def show
    tickets = params[:all] && params[:role] == 'admin' ? @event.tickets : @event.tickets.where(status: :accessed)
    render json: { event: @event, tickets: tickets }, status: :ok
  end

  # Создавать билеты может только администратор
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
