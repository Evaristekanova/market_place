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
    
    validates :total_amount, presence: true, numericality: {greater_than_or_equal_to: 0}

    def total_amount
      order_items.joins(:product).sum("order_items.quantity * products.price")
    end
end
