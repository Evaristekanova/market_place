class OrderSerializer
include JSONAPI::Serializer
  attributes :id, :total_amount, :created_at, :updated_at, :order_items
end