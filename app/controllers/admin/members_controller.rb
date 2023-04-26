class Admin::MembersController < ApplicationController

  before_action :authenticate_admin!

  def index
    @members = Member.all
  end

  def show
    @member = Member.find(params[:id])
    @posts = @member.posts
  end

  def edit
    @member = Member.find(params[:id])
  end

  def update
    @member = Member.find(params[:id])
    if @member.update(member_params)
      flash[:notice] = "通知：会員情報の編集が完了しました。"
      redirect_to admin_member_path(@member.id)
    else
      render :edit
    end
  end

  private

  def member_params
    params.require(:member).permit(:email, :name, :age, :composition, :introduction, :is_deleted)
  end

end
