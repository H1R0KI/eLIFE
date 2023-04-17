class Public::FavoritesController < ApplicationController

  before_action :authenticate_member!

  def create
    @post = Post.find(params[:post_id])
    unless @post.favorited_by?(current_member)
      favorite = @post.favorites.new(member_id: current_member.id)
      favorite.save
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    favorite = @post.favorites.find_by(member_id: current_member.id)
    favorite.destroy
  end

end
