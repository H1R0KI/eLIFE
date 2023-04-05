class Public::Members::SessionsController < Devise::SessionsController
  def guest_sign_in
    member = Member.guest
    sign_in member
    redirect_to posts_path, notice: 'ゲストログインしました。'
  end
end