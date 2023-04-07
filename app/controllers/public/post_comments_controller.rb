class Public::PostCommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @post_comment = PostComment.new(post_comment_params)
    @post_comment.member_id = current_member.id
    @post_comment.post_id = @post.id
    @post_comment.save
    redirect_to post_path(@post.id)
  end

  def destroy
    @post = Post.find(params[:post_id])
    post_comment = current_member.post_comments.find_by(post_id: @post.id)
    post_comment.destroy
    redirect_to post_path(@post.id)
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

end
