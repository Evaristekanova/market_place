class OrderItemSerializer
include JSONAPI::Serializer
  attributes :id, :quantity, :subtotal, :product, :order
end