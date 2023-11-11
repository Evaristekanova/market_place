class API::V1::ProductsController < APIController
  def index
    @products = Product.all
    product_response = ProductSerializer.new(@products).serializable_hash[:data].map{|p| p[:attributes]}
    render json: {data: product_response}, status: :ok
  end

    def show
        @product = Product.find(params[:id])
        render json: ProductSerializer.new(@product).serializable_hash[:data][:attributes], status: :ok
    end
end
