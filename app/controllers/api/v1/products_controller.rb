class API::V1::ProductsController < APIController

    def index
      @products = Product.filter(params.slice(:published, :product_name, :product_description, :product_price_min, :product_price_max))
      
      if @products.present?
        product_response = ProductSerializer.new(@products).serializable_hash[:data].map{|p| p[:attributes]}
        render json: {data: product_response}, status: :ok
      else
        render json: { message: "No products found for the given criteria" }, status: :not_found
      end
    end

    def show
        @product = Product.find(params[:id])
        render json: ProductSerializer.new(@product).serializable_hash[:data][:attributes], status: :ok
    end
end
