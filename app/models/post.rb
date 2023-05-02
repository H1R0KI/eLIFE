class Post < ApplicationRecord

  belongs_to :member
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  has_many_attached :image

  validates :title, presence:true
  validates :body, presence:true

  scope :latest, -> {order(created_at: :desc)}
  scope :old, -> {order(created_at: :asc)}
  scope :favorites_count, -> {order(favorites: :desc)}

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

  #キーワードがタイトルか本文に入っていれば結果に表示する
  def self.search_for(content, method)
    Post.where("title LIKE ?", "%" + content + "%")
    Post.where("body LIKE ?", "%" + content + "%")
  end

  #同じユーザーが同じ投稿に複数いいねできないようにする
  def favorited_by?(member)
    favorites.exists?(member_id: member.id)
  end

  enum genre: { cleaning: 0, laundry: 1, cooking: 2, care: 3, other: 4}

end
