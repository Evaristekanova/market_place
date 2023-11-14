class API::V1::CommentsController < APIController
  before_action :authenticate_user!

  def create
    @comment = Comment.create!(comment_params.merge(commentable_id: current_user.id))
    render json: CommentSerializer.new(@comment).serializable_hash[:data][:attributes], status: :ok
  end

  private

  def comment_params
    params.permit(:content, :commentable_id, :commentable_type)
  end

  def authenticate_user!
    puts "current_user: #{current_user}"
    return render json: { error: 'Login first before you make a comment' }, status: :unauthorized unless current_user.present?
  end
end
