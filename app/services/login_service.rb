class LoginService
  attr_reader :params, :session

  def initialize(params, session)
    @params = params
    @session = session
  end

  def call
    check_password
    message
  end

  private

  def check_password
    @session[:login] = @params[:login] if @params[:password] == @user.password
  end

  def message
    if @session[:login]
      case Time.now.hour
      when 0..5
        'Доброй ночи, '
      when 6..11
        'С добрым утром, '
      when 12..17
        'Добрый день, '
      when 18..24
        'Добрый вечер, '
      end + @session[:login]
    else
      'Неверный пароль'
    end
  end
end
