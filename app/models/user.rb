class User < ApplicationRecord
  enum role: [:customer, :admin]

  has_secure_password
  has_many :accounts

  accepts_nested_attributes_for :accounts, :reject_if => :all_blank, allow_destroy: true

  validates :email, presence: true, uniqueness: true,
    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }

  validates :password, presence: true, length: { in: 8..32 }, allow_nil: true

  after_initialize :set_role

  def admin?
    self.role.to_sym == :admin
  end

  private

  def set_role
    if self.new_record?
      self.role = :admin unless account.present?
    end
  end

  def account
    Account.find_by(user: self)
  end
end
