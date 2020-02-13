class CommentOfComment < ApplicationRecord
	validates :content, presence: true
	belongs_to :user
	belongs_to :comment
end
