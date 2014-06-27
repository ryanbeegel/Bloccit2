class CommentsController < ApplicationController

  respond_to :html, :js
  
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

  def destroy
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])

    @comment = @post.comments.find(params[:id])

    authorize @comment
    if @comment.destroy
      flash[:notice] = "Comment was removed."
      redirect_to [@topic, @post]
    else
      flash[:error] = "Comment couldn't be deleted. Try again."
      redirect_to [@topic, @post]
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :post_id)
  end
end