# == Schema Information
#
# Table name: products
#
#  id          :bigint           not null, primary key
#  description :string
#  name        :string
#  price       :decimal(, )
#  published   :boolean
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Product < ApplicationRecord
    include Filterable
    has_one_attached :image
    
    has_and_belongs_to_many :wish_lists
    has_many :comments, as: :commentable

    validates :name, presence: true
    validates :price, presence: true, numericality: {greater_than_or_equal_to: 0}
    validates :description, presence: true

    scope :published, -> {where(published: true)}
    scope :by_name, -> (name) {where("LOWER(name) LIKE ?", "%#{name.downcase}%")}
    scope :description, -> (description) {where("LOWER(description) LIKE ?", "%#{description.downcase}%")}
    scope :price_min, -> (min_price) {where("price >= ?", min_price)}
    scope :price_max, -> (max_price) {where("price <= ?", max_price)}

    def product_picture_url
        Rails.application.routes.url_helpers.url_for(image) if image.attached?
    end
    
    def self.ransackable_attributes(auth_object = nil)
        ["created_at", "description", "id", "name", "price", "published", "updated_at"]
    end
end
