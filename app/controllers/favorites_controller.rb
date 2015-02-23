class FavoritesController < ApplicationController
  
def create
  @post = Post.find(params[post_id])
  favorite = current.user.favorites.build(post: @post)

  authorize@favorite
  if favorite.save
      flash[:notice] = "you favorited this post"
      redirect_to [@post.topic, @post]
    else
      flash[:error] = "There was an error Please try again."
      redirect_to [@post.topic, @post] :
    end
  end

  def destroy
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(param[post_id])
    @favorite = current.user.favorites.find(params[:id])

    authorize@favorite
    
    if favorite.destroy
      flash[:notice] = "you favorited was removed"
      redirect_to [@post.topic @post]
    else
      flash[:error] = "unable to remove favorite, please try again"
      redirect_to [@post.topic, @post]
  end

end
