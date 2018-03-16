class DispatchActionService
  def initialize(action, args)
    @action = action
    @args = args
  end

  def run
    email, password, subdomain = params

    case @action
    when :authenticate
      command = AuthenticateUserCommand.call(email, password, subdomain)
    when :register
      command = RegisterUserCommand.call(email, password, subdomain)
    else
      raise Exception("Action not supported")
    end

    [command.success?, command.result, command.errors]
  end

  private

  def params
    email = get_user_param(:email)
    password = get_user_param(:password)
    subdomain = get_account_param(:subdomain)

    [email, password, subdomain]
  end

  def get_account_param(param)
    @args.try(:[], :account).try(:[], param)
  end

  def get_user_param(param)
    get_account_param(:user).try(:[], param)
  end
end
