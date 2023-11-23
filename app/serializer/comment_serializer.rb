class CommentSerializer
include JSONAPI::Serializer
    attributes :id, :content, :commentable_id, :commentable_type, :created_at, :updated_at
end