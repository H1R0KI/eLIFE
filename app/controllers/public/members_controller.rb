class Public::MembersController < ApplicationController

  before_action :authenticate_member!

  def index
    @members = Member.all
  end

  def show
    @member = Member.find(params[:id])
 #   @posts = @member.posts
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

  private
  def member_params
    params.require(:member).permit(:name, :profile_image, :age, :composition, :introduction)
  end

#  def ensure_guest_user
#    @user = User.find(params[:id])
#    if @user.name == "guestuser"
#      redirect_to user_path(current_user), notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
#    end
#  end

end
