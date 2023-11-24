# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  email           :string
#  first_name      :string
#  last_name       :string
#  password_digest :string
#  phone           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
    has_secure_password
    
    has_one :wish_list
    has_many :wished_products, through: :wish_list, source: :products
    has_many :comments, as: :commentable
    has_many :orders

    validates :email, presence: true, uniqueness: true
    validates :phone, presence: true, uniqueness: true

    after_create :send_welcome_email

    def send_welcome_email
        UserMailer.with(user: self).welcome_email.deliver_now
    end
end
