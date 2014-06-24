class CommentsController < ApplicationController
  def create
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:post_id])
    @comments = @post.comments
    @comment = Comment.new

    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      flash[:notice] = "Your comment was created"
    else
      flash[:error] = "Whoops! There was a problem saving this comment."
    end
 
    respond_with(@comment) do |f|
      f.html {redirect_to [@topic, @post]}
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :post_id)
  end
end