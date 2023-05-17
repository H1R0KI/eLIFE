class Public::HomesController < ApplicationController

  def top
    #一週間のいいねが多い順に投稿を5件取得
    @week_post_favorite_ranks = Post.find(Favorite.group(:post_id).where(created_at: Time.current.all_week).order('count(post_id) desc').limit(5).pluck(:post_id))
    #一ヶ月の投稿数が多いユーザーを5人取得
    @month_member_post_ranks = Member.find(Post.group(:member_id).where(created_at: Time.current.all_month).order('count(member_id) desc').limit(5).pluck(:member_id))
  end

end
