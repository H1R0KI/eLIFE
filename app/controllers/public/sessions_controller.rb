# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  before_action :member_state, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected

  def member_state
    @member = Member.find_by(email: params[:member][:email])
    return if !@member
    if @member.valid_password?(params[:member][:password]) && @member.is_deleted == true
      flash[:notice] = "通知：このアカウントは退会済み、または使用停止中です。"
      redirect_to new_member_session_path
    end
  end

end
