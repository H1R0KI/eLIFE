class Public::PostsController < ApplicationController

  before_action :authenticate_member!, only: [:create, :destroy, :update]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.member_id = current_member.id
    tag_list = params[:post][:tag_name].split(",")
    if @post.save
      @post.save_tag(tag_list)
      flash[:notice] = "投稿しました"
      redirect_to post_path(@post)
    else
      @posts = Post.all
      render 'index'
    end
  end

  def index
    @posts = Post.all.order(created_at: :desc).page(params[:page]).per(5)
    @tags = Tag.all
  end

  def show
    @post = Post.find(params[:id])
    @post_tags = @post.tags
    @post_comment = PostComment.new
  end

  def edit
    @post = Post.find(params[:id])
    @post_tags = @post.tags
    unless @post.member.id == current_member.id
      redirect_to post_path(@post.id)
    end
  end

  def update
    @post = Post.find(params[:id])
    tag_list = params[:post][:tag_name].split(",")
    if @post.update(post_params)
      @old_tags = PostTag.where(post_id: @post.id)
      @old_tags.each do |tag|
        tag.delete
      end
      @post.save_tag(tag_list)
      flash[:notice] = "投稿を更新しました"
      redirect_to post_path(@post.id)
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = "投稿を削除しました"
    redirect_to posts_path
  end

  def search
      @tags = Tag.all
      @tag = Tag.find(params[:tag_id])
      @posts = @tag.posts.all.page(params[:page])
  end

  private

  def post_params
    params.require(:post).permit(:title, :genre, :body, image: [])
  end

end
