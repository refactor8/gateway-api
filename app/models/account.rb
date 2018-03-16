class Account < ApplicationRecord
  belongs_to :user
  validates :subdomain,
    presence: true,
    uniqueness: true,
    length: { in: 2..63 },
    format: { with: /\A^(?!kovadonga)^(?!mykovadonga)[a-zA-Z]+[\-]?[\d]*(?<!\W)$\z/ }
end
