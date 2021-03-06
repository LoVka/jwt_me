class Dialog
  MAX_NUM = 10
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  def params
    @params ||= {}
  end

  def ask_params(param_num = 1)
    key = ask("Enter key #{param_num}").to_sym
    value = ask "Enter #{key} value"
    if key == :email
      while value !~ VALID_EMAIL_REGEX do
        value = ask 'Invalid email entered! Enter email value'
      end
    end
    params[key] = value
    if param_num == 1 || param_num < MAX_NUM && ask('Any additional inputs? (yes/no)') == 'yes'
      ask_params(param_num + 1)
    end
  end

  attr_reader :error_messages

  def valid?
    @error_messages = []
    @error_messages << 'User_id is requered' unless params.key?(:user_id) && params[:user_id] != ''
    @error_messages << 'Email is requered' unless params.key?(:email) && params[:email] != ''
    @error_messages.empty?
  end

  private
  def ask(text)
    puts text
    gets.to_s.chomp
  end
end
