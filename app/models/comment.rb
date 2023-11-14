# == Schema Information
#
# Table name: comments
#
#  id               :bigint           not null, primary key
#  commentable_type :string
#  content          :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  commentable_id   :bigint
#
# Indexes
#
#  index_comments_on_commentable  (commentable_type,commentable_id)
#
class Comment < ApplicationRecord
    
    belongs_to :commentable, polymorphic: true

    validates :content, presence: true
end
