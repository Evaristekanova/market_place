# == Schema Information
#
# Table name: orders
#
#  id           :bigint           not null, primary key
#  order_date   :date
#  total_amount :decimal(, )
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :bigint           not null
#
# Indexes
#
#  index_orders_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Order < ApplicationRecord
    belongs_to :user
    has_many :order_items
    has_many :products, through: :order_items
    
    validates :order_date, presence: true
    validates :total_amount, presence: true, numericality: {greater_than_or_equal_to: 0}
    
    def self.ransackable_attributes(auth_object = nil)
        ["created_at", "order_date", "total_amount", "updated_at"]
    end

    def total_amount
        order_items.collect { |oi| oi.valid? ? (oi.quantity * oi.unit_price) : 0 }.sum
    end
end
