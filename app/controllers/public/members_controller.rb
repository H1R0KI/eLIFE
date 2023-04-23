class Public::MembersController < ApplicationController

  before_action :authenticate_member!, only: [:edit, :update]
  before_action :set_member, only: [:favorites]

  def index
    @members = Member.all.page(params[:page]).per(10)
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

  def quit_check
    @member = current_member
  end

  def quit
    @member = current_member
    @member.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理が完了しました。ご利用ありがとうございました。"
    redirect_to root_path
  end

  private
  def member_params
    params.require(:member).permit(:name, :profile_image, :age, :composition, :introduction, :is_deleted)
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
