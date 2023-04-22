class Public::HomesController < ApplicationController

  def top
    @week_post_favorite_ranks = Post.find(Favorite.group(:post_id).where(created_at: Time.current.all_week).order('count(post_id) desc').limit(5).pluck(:post_id))
    @month_member_post_ranks = Member.find(Post.group(:member_id).where(created_at: Time.current.all_month).order('count(member_id) desc').limit(5).pluck(:member_id))
  end

end
