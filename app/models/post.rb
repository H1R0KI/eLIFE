class Post < ApplicationRecord

  belongs_to :member
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  has_many_attached :image

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no.jpeg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end


  #投稿のタグ付け機能
  def save_tag(sent_tags)
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    old_tags = current_tags - sent_tags
    new_tags = sent_tags - current_tags

    old_tags.each do |old|
      self.tags.delete Tag.find_by(name: old)
    end

    new_tags.each do |new|
     new_tag = Tag.find_or_create_by(name: new)
      self.tags << new_tag
    end
  end

  #検索の一致方法分岐
  def self.search_for(content, method)
    if method == "perfect"
      Post.where(title: content) #完全一致
    elsif method == "forward"
      Post.where("title LIKE ?", content + "%") #前方一致
    elsif method == "backward"
      Post.where("title LiKE ?", "%" + content) #後方一致
    else
      Post.where("title LIKE ?", "%" + content + "%") #部分一致
    end
  end

  #同じユーザーが同じ投稿に複数いいねできないようにする
  def favorited_by?(member)
    favorites.exists?(member_id: member.id)
  end

end
