class Public::MembersController < ApplicationController

  before_action :authenticate_member!
  before_action :set_member, only: [:favorites]

  def index
    @members = Member.all
  end

  def show
    @member = Member.find(params[:id])
    @posts = @member.posts
  end

  def edit
    @member = Member.find(params[:id])
    unless @member.id == current_member.id
      redirect_to member_path(current_member.id)
    end
  end

  def update
    @member = Member.find(params[:id])
    if @member.update(member_params)
      flash[:notice] = "プロフィールを更新しました"
      redirect_to member_path(@member.id)
    else
      render :edit
    end
  end

  def posts
    @member = Member.find(params[:id])
    @posts = @member.posts
  end

  def favorites
    favorites = Favorite.where(member_id: @member.id).pluck(:post_id)
    @favorite_posts = Post.find(favorites)
  end

  private
  def member_params
    params.require(:member).permit(:name, :profile_image, :age, :composition, :introduction)
  end

  def set_member
    @member = Member.find(params[:id])
  end
#  def ensure_guest_member
#    @member = Member.find(params[:id])
#    if @member.name == "guestmember"
#      redirect_to member_path(current_member), notice: "ゲストはプロフィール編集画面へ遷移できません。"
#    end
#  end

end
