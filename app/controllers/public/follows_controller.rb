class Public::FollowsController < ApplicationController
  # フォローするとき
  def create
    @member = Member.find(params[:member_id])
    current_member.follow(params[:member_id])
  end
  # フォロー外すとき
  def destroy
    @member = Member.find(params[:member_id])
    current_member.unfollow(params[:member_id])
  end
  # フォロー一覧
  def followings
    member = Member.find(params[:member_id])
    @members = member.followings
  end
  # フォロワー一覧
  def followers
    member = Member.find(params[:member_id])
    @members = member.followers
  end
end
