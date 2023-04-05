class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :image

  def get_profile_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/member.jpeg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
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
