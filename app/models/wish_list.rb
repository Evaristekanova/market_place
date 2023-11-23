# == Schema Information
#
# Table name: wish_lists
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_wish_lists_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class WishList < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :products
end
