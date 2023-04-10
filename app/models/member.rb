class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  # フォローをした、されたの関係
  has_many :follows, class_name: "Follow", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_follows, class_name: "Follow", foreign_key: "following_id", dependent: :destroy
  # 一覧画面で使う
  has_many :followings, through: :follows, source: :following
  has_many :followers, through: :reverse_of_follows, source: :follower

  validates :name, uniqueness: true, length: { in: 2..20 }
  validates :introduction, length: { maximum: 100 }

  has_one_attached :profile_image

  def get_profile_image
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/member.jpeg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image
  end

  # ゲストログイン登録情報
  def self.guest
    find_or_create_by!(name: 'guestmember' ,email: 'guest@example.com') do |member|
      member.password = SecureRandom.urlsafe_base64
      member.name = "guestmember"
    end
  end

  #検索方法分岐
  def self.search_for(content, method)
    if method == "perfect"
      Member.where(name: content)
    elsif method == "forward"
      Member.where("name LIKE ?", content + "%")
    elsif method == "backward"
      Member.where("name LiKE ?", "%" + content)
    else
      User.where("name LIKE ?", "%" + content + "%")
    end
  end

  #フォロー機能
  def follow(member_id)
    follows.create(following_id: member_id)
  end

  def unfollow(member_id)
    follows.find_by(following_id: member_id).destroy
  end

  def following?(member)
    followings.include?(member)
  end

  enum age: { teens: 0, twenties: 1, thirties: 2, forties: 3, fifties: 4, sixties: 5}
  enum composition: { solitary: 0, couple: 1, family: 2, family_and_relative: 3, others: 4}

end
