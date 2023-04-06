class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  validates :name, uniqueness: true, length: { in: 2..20 }
  validates :introduction, length: { maximum: 50 }

  has_one_attached :profile_image

  def get_profile_image
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/member.jpeg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image
  end

  def self.guest
    find_or_create_by!(name: 'guestmember' ,email: 'guest@example.com') do |member|
      member.password = SecureRandom.urlsafe_base64
      member.name = "guestmember"
    end
  end

  enum age: { teens: 0, twenties: 1, thirties: 2, forties: 3, fifties: 4, sixties: 5}
  enum composition: { solitary: 0, couple: 1, family: 2, family_and_relative: 3, others: 4}

end
