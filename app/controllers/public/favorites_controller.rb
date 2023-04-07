class Public::FavoritesController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    unless @post.favorited_by?(current_member)
      favorite = @post.favorites.new(member_id: current_member.id)
      favorite.save
      redirect_to posts_path
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    favorite = @post.favorites.find_by(member_id: current_member.id)
    favorite.destroy
    redirect_to posts_path
  end

end
