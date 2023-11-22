class API::V1::WishListsController < APIController
    before_action :authenticate_user!
    
    def index
        @wish_list = current_user.wish_list

        # returning response in list instead of object
        render json: [WishListSerializer.new(@wish_list).serializable_hash[:data][:attributes]], status: :ok
    end

    def create
      @wish_list = current_user.wish_list || current_user.create_wish_list
      @product = Product.find(wish_list_params[:product_id])
      if @wish_list.products.include?(@product)
        render json: { error: 'Product already in wishlist' }, status: :unprocessable_entity
      else
        @wish_list.products << @product
        render json: WishListSerializer.new(@wish_list).serializable_hash[:data][:attributes], status: :created
      end
    end



    def destroy
        @wish_list = current_user.wish_list
        @product = Product.find(wish_list_params[:product_id])
        @wish_list.products.delete(@product)
        render json: WishListSerializer.new(@wish_list).serializable_hash[:data][:attributes], status: :ok
    end
    private

    def wish_list_params
        params.permit(:product_id)
    end

    def authenticate_user!
        @user = current_user
    end
end