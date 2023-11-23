class ProductSerializer
include JSONAPI::Serializer
    attributes :id, :name, :price, :description, :published, :product_picture_url, :created_at, :updated_at, :comments
end