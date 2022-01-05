class AccountActivity < ApplicationRecord
    belongs_to :user
    validates :remarks, presence: true, length: { maximum: 255 }
    validates :give_take, presence: true, length: { maximum: 255 }
    validates :price, numericality: true, length: { maximum: 255 }
    validates :balance, numericality: true, length: { maximum: 255 }
end
