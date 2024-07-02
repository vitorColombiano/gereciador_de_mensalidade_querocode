class Student < ApplicationRecord
    validates :name, presence: true
    validates :cpf, presence: true, uniqueness: true, format: { with: /\A(\d{3}\.\d{3}\.\d{3}-\d{2}|\d{11})\z/, message: "must be in the format XXX.XXX.XXX-XX or XXXXXXXXXXX" }
    validates :birthdate, presence: true
    validates :payment_method, presence: true, inclusion: { in: %w(credit_card boleto) }
end
