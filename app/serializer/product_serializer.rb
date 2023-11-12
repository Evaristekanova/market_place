class ProductSerializer
include JSONAPI::Serializer
    attributes :name, :price, :description, :published, :product_picture_url
end