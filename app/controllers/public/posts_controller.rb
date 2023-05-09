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
      flash[:notice] = "通知：投稿に成功しました"
      redirect_to post_path(@post)
    else
      @posts = Post.all
      render 'new'
    end
  end

  def index
    if params[:latest]
      @posts = Post.latest.page(params[:page]).per(5)
    elsif params[:old]
      @posts = Post.old.page(params[:page]).per(5)
    else
      @posts = Post.all.page(params[:page]).per(5)
    end

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
      flash[:notice] = "通知：投稿を編集しました"
      redirect_to post_path(@post.id)
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = "通知：投稿を削除しました"
    redirect_to posts_path
  end

  def search
      @tags = Tag.all
      @tag = Tag.find(params[:tag_id])
      @posts = @tag.posts.all.page(params[:page])
  end

  private

  def post_params
    params.require(:post).permit(:title, :genre_id, :body, image: [])
  end

end
