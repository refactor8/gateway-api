class RegisterUserCommand < BaseCommand

  attr_reader :args

  def initialize(email, password, subdomain)
    @args = OpenStruct.new(email: email,
      password: password,
      subdomain: subdomain,
      account: Account.find_by(subdomain: subdomain),
      user: User.find_by(email: email))
  end

  private

  def token
    @result = JwtService.encode(contents) if valid?
  end

  def valid?
    return if email.blank? || password.blank? || subdomain.blank?

    if account.blank?
      if user.blank?
        save_user
      else
        update_user
      end
    end
  end

  def payload
    token || render_errors
  end

  def render_errors
    errors.add(:base, account.errors.details) unless account.blank? || account.valid?
    errors.add(:base, I18n.t('register_user_command.email')) if email.blank?
    errors.add(:base, I18n.t('register_user_command.password')) if password.blank?
    errors.add(:base, I18n.t('register_user_command.subdomain')) if subdomain.blank?
  end

  def account
    @args.account
  end

  def user
    @args.user
  end

  def password
    @args.password
  end

  def email
    @args.email
  end

  def subdomain
    @args.subdomain
  end

  def save_user
    user = new_user
    user.accounts << new_account
    user.save!
  end

  def update_user
    user.accounts << new_account
    user.save!
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

  def new_account
    @args.account = Account.new(subdomain: args.subdomain)
    account
  end

  def new_user
    @args.user = User.new(email: email, password: password)
    user
  end
end
