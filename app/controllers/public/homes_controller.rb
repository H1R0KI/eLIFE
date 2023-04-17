class Public::HomesController < ApplicationController

  def top
    @week_post_favorite_ranks = Post.find(Favorite.group(:post_id).order('count(post_id) desc').limit(5).pluck(:post_id))
    @member_post_ranks = Member.where(id: Post.group(:member_id).order('count(member_id) desc').limit(5).pluck(:member_id))
  end

end
