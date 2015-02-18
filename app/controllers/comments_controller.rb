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



private
  def comment_params
    params.require(:comment).permit(:body)
  end

end





