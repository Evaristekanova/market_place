class WishListSerializer
include JSONAPI::Serializer
    attributes :id, :created_at, :updated_at, :products
end