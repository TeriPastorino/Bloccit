class CommentsController < ApplicationController

def create
   
   @topic = Topic.find(params[:topic_id])
   @post = @topic.posts.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.user_id = current_user.id
  #authorize @comment

  if @comment.save
      redirect_to [@topic, @post], notice: "Comment saved successfully."
    else
      redirect_to [@topic, @post], notice: "Comment failed to save."
    end
  end

def destroy
  #@topic = Topic.find(params[:topic_id]) - change shallow nesting
  @post = Post.find(params[:post_id])
  @topic = @post.topic
  @comment = @post.comments.find(params[:id])

  authorize @comment
  if @comment.destroy
    flash[:notice] = "Comment was removed"
  else
    flash[:error] = "Sorry you are not authorized to delete this comment"
  end

  respond_to do |format|
    format.html
    format.js
  end
end





private
  def comment_params
    params.require(:comment).permit(:body)
  end

end





