class ActionsController < ApplicationController
  before_action :validate_params, only: %i[enter exit]
  before_action :validate_zone, only: %i[enter exit]
  before_action :last_action, only: %i[enter exit]
  after_action :save_action, only: %i[enter exit]

  def index
    render json: Action.all.as_json(except: [:updated_at])
  end

  def enter
    pp @last_action

    @action = Action.new(action: 1, fio: @params[:fio], ticket_id: @params[:ticket_id])

    if @last_action['action'] == 'enter'
      @action.status = false
      return render json: { result: 'false', error: 'Already entered' }
    end

    @action.status = true
    render json: { result: 'true' }
  end

  def exit
    @action = Action.new(action: 0, fio: @params[:fio], ticket_id: @params[:ticket_id])

    if @last_action['action'] == 'exit'
      @action.status = false
      return render json: { result: 'false', error: 'Already exited' }
    end

    @action.status = true
    render json: { result: 'true' }
  end

  private

  def validate_params
    raise ArgumentError, 'Empty ticket id' unless params[:ticket_id]
    raise ArgumentError, 'Empty zone type' unless params[:zone_type]

    @params = {}
    @params[:ticket_id] = params[:ticket_id]
    @params[:zone_type] = params[:zone_type]
  rescue ArgumentError => e
    render json: { result: 'false', error: e }, status: :not_acceptable
  end

  def validate_zone
    # ticket = FetchService.call("http://data:3000/tickets/#{@params[:ticket_id]}")
    ticket = { 'fio' => "fio_#{rand(100..200)}", 'type' => '1' } # заглушка

    # if no such ticket_id
    return render json: { result: 'false', error: 'Wrong zone type' }, status: :not_acceptable unless ticket

    @params[:fio] = ticket['fio']

    return if ticket['type'] == @params[:zone_type]

    Action.create(action: params['action'], fio: @params[:fio], status: false, ticket_id: @params[:ticket_id])
    render json: { result: 'false', error: 'Wrong zone type' }, status: :not_acceptable
  end

  def last_action
    @last_action = Action.where(ticket_id: @params[:ticket_id], status: true)
                         .order('created_at DESC').first.as_json
    return if @last_action

    @last_action = { 'action' => 'exit', 'fio' => @params[:fio], 'status' => true, 'ticket_id' => @params[:ticket_id] }
  end

  def save_action
    @action.save
  end
end
