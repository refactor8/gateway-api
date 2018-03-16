class AuthenticateUserCommand < BaseCommand
  attr_reader :args

  private

  def initialize(email, password, subdomain)
    @args = OpenStruct.new(email: email, password: password, account: Account.find_by(subdomain: subdomain))
  end

  def token
    @result = JwtService.encode(contents) if valid?
  end

  def valid?
    return if account.blank?
    user && authenticate && admin
  end

  def payload
    token || render_errors
  end

  def render_errors
    errors.add(:base,
      {
        field: 'error',
        message: I18n.t('authenticate_user_command.credentials.invalid')
      }
    )
  end

  def account
    @args.account
  end

  def user
    @args.account.user
  end

  def contents
    {
      user_id: user.id,
      email:   user.email,
      admin:   user.admin?,
      my_kovadonga_domain: account.subdomain,
      exp: 24.hours.from_now.to_i
    }
  end

  def authenticate
    user.authenticate(args.password)
  end

  def admin
    user.admin?
  end
end
