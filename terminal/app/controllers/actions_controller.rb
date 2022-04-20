class ActionsController < ApplicationController
  before_action :validate_params, only: %i[enter exit]
  before_action :last_action, only: %i[enter exit]

  after_action :save_action, only: %i[enter exit]

  # Вывод журнала
  def index
    journal = ActionSelectorService.new(params).call.as_json(except: [:updated_at])
    pp(journal)
    render json: journal
  end

  # Вход
  # - создаем новую запись
  # - проверяем возможность входа
  def enter
    @action = Action.new(action_type: :enter, fio: @ret[:fio], ticket_id: @ret[:ticket_id])

    render json: ActionService.new('enter', @action, @last_action).call
  end

  # Выход (аналогично)
  def exit
    @action = Action.new(action_type: :exit, fio: @ret[:fio], ticket_id: @ret[:ticket_id])

    render json: ActionService.new('exit', @action, @last_action).call
  end

  # Проверяем query
  def validate_params
    @ret = ActionParamsService.new(params).call

    return unless @ret[:response]

    render json: @ret[:response], status: :not_acceptable
  end

  # Получаем последнее успешное событие
  def last_action
    @last_action = Action.where(ticket_id: @ret[:ticket_id]).last_action

    @last_action = { 'action_type' => 'exit' } if @last_action.blank?
  end

  # Сохраняем новую запись
  def save_action
    @action.save
  end
end
