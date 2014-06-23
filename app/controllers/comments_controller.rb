class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.build(params.require(:comment).permit(:body, :post_id))
  end
end
