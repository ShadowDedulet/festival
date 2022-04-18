class ActionsController < ApplicationController
  before_action :validate_params, only: %i[enter exit]
  before_action :last_action, only: %i[enter exit]

  after_action :save_action, only: %i[enter exit]


  # Вывод всего журнала
  def index
    render json: Action.all.as_json(except: [:updated_at])
  end


  # Вход
  # - создаем новую запись
  # - проверяем возможность входа
  def enter
    @action = Action.new(action: 1, fio: @ret[:fio], ticket_id: @ret[:ticket_id])

    return render json: ActionService.new('enter', @action, @last_action).call
  end


  # Выход (аналогично)
  def exit
    @action = Action.new(action: 0, fio: @ret[:fio], ticket_id: @ret[:ticket_id])

    return render json: ActionService.new('exit', @action, @last_action).call
  end

  private

  # Проверяем query
  def validate_params
    @ret =  ActionParamsService.new(params).call

    if @ret[:response]
      @action = Action.new(
        action: params['action'], fio: @ret[:fio], status: false, ticket_id: @ret[:ticket_id]
      ) if @ret[:fio] && @ret[:ticket_id]

      render json: @ret[:response], status: :not_acceptable
    end
  end

  # Получаем последнее успешное событие
  def last_action
    @last_action = Action.where(ticket_id: @ret[:ticket_id], status: true).order('created_at DESC').first

    @last_action = { 'action' => 'exit' } if @last_action.blank?
  end
  
  # Сохраняем новую запись
  def save_action
    @action.save
  end
end
