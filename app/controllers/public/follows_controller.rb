class Public::FollowsController < ApplicationController

  def create
    @member = Member.find(params[:member_id])
    current_member.follow(params[:member_id])
  end

  def destroy
    @member = Member.find(params[:member_id])
    current_member.unfollow(params[:member_id])
  end

  def followings
    member = Member.find(params[:member_id])
    @member = Member.find(params[:member_id])
    @members = member.followings
  end

  def followers
    member = Member.find(params[:member_id])
    @member = Member.find(params[:member_id])
    @members = member.followers
  end
end
