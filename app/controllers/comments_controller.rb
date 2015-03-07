class CommentsController < ApplicationController



def create
    @post = Post.find(params[:post_id])
    @comments = @post.comments

    @comment = current_user.comments.build( comment_params )
    @comment.post = @post
      @new_comment = Comment.new

    authorize @comment

    if @comment.save
      flash[:notice] = "Comment was created."
    else
      flash[:error] = "There was an error saving the comment. Please try again."
    end

respond_to do |format|
      format.html
      format.js
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





