class Admin::PostsController < ApplicationController
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = "通知：投稿を削除しました"
    redirect_to request.referer
  end
end
