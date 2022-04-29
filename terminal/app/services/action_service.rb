# Сервис для проверки возможности совершения события
class ActionService
  def initialize(action_name, action_obj, last_action)
    @action_name = action_name
    @action_obj = action_obj
    @last_action = last_action
  end

  def call
    # Попытка повторить событие
    if @last_action['action_type'] == @action_name
      @action_obj.status = false
      return { result: 'false', error: "Already #{@action_name}ed" }
    end

    # Все ок
    @action_obj.status = true
    { result: 'true' }
  end
end
