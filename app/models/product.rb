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
    has_one_attached :image

    validates :name, presence: true
    validates :price, presence: true, numericality: {greater_than_or_equal_to: 0}
    validates :description, presence: true

    scope:published, -> {where(published: true)}
    scope:unpublished, -> {where(published: false)}
    scope:product_name, -> (name) {where("LOWER(name) LIKE ?", "%#{name.downcase}%")}
    scope:product_description, -> (description) {where("LOWER(description) LIKE ?", "%#{description.downcase}%")}
    scope:product_price_min, -> (min_price) {where("price >= ?", min_price)}
    scope:product_price_max, -> (max_price) {where("price <= ?", max_price)}


    def self.search(params={})
        products = Product.all
        products = params[:published] == "true" ? products.merge(Product.published) : products.merge(Product.unpublished) if params[:published] == "true" || params[:published] == "false"
        products = products.merge(Product.product_name(params[:name])) if params[:name].present?
        products = products.merge(Product.product_description(params[:description])) if params[:description].present?
        products = products.merge(Product.product_price_min(params[:min_price])) if params[:min_price].present?
        products = products.merge(Product.product_price_max(params[:max_price])) if params[:max_price].present?

        products
    end

    def product_picture_url
        Rails.application.routes.url_helpers.url_for(image) if image.attached?
    end
    
    def self.ransackable_attributes(auth_object = nil)
        ["created_at", "description", "id", "name", "price", "published", "updated_at"]
    end

end
