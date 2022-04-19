# Сервис для поиска по заданным параметрам
class ActionSelectorService
  def initialize(params)
    @params = params
    @fields = %w[action_type created_at fio status ticket_id]
  end

  def call
    return sort_by if @params.key?(:sort_by)

    find_by
  end

  def find_by
    filter = {}
    @fields.each { |i| filter[i] = @params[i] if @params.key?(i) }
    return Action.all unless filter

    Action.where(filter)
  end

  def sort_by
    filter = @params[:sort_by].map { |w| w if @fields.include?(w) }.compact
    return Action.all unless filter

    return Action.order(filter).reverse_order if @params[:reverse]

    Action.order(filter)
  end
end
