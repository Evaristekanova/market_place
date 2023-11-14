class API::V1::ProductsController < APIController

    def index
      @products = Product.filter(filter_params)
        
      product_response = ProductSerializer.new(@products).serializable_hash[:data].map{|p| p[:attributes]}
      render json: { data: product_response }, status: :ok
    end

    def show
        @product = Product.includes(comments: :user).find(params[:id])
        render json: ProductSerializer.new(@product).serializable_hash[:data][:attributes], status: :ok
    end

    private

    def filter_params
      params.permit(:by_name, :description, :price_min, :price_max)
    end
end
