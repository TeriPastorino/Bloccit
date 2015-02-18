class CommentsController < ApplicationController

def create
   
  #@comment = current_user.comments.build(comment_params)
  @post = Post.find(params[:post_id])
  @topic = @post.topic

  # @comment = Comment.new(comment_params)
  # @comment.user = current_user

  @comment = current_user.comments.build(comment_params)
  @comment.post = @post

  #authorize @comment

  if @comment.save
    flash[:notice] = "Comment was saved."    
  else
    flash[:error] = "There was an error saving the comment. Please try again."
  end
  redirect_to [@topic, @post]  # post show page, nested under topic
end

def destroy
  #@topic = Topic.find(params[:topic_id]) - change shallow nesting
  @post = posts.find(params[:post_id])
  @comment = @post.comments.find(params[:id])

  authorize @comment
  if @comment.destroy
    flash[:notice] = "Comment was removed"
    redirect_to [@topic, @post]
  else
    flash[:error] = "Sorry you are not authorized to delete this comment"
    redirect_to [@topic, @post]
  end
end





private
  def comment_params
    params.require(:comment).permit(:body)
  end

end





