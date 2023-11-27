class UserSerializer
include JSONAPI::Serializer

  attributes :id, :email, :first_name, :last_name, :created_at, :updated_at, :wish_list, :order_items, :orders

  attribute :wish_list do |user|
      WishListSerializer.new(user.wish_list).serializable_hash[:data][:attributes]
  end
end