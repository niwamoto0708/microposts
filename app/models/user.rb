class User < ActiveRecord::Base
    before_save { self.email = self.email.downcase }
    validates :name, presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 },
                        format: { with: VALID_EMAIL_REGEX },
                        uniqueness: { case_sensitive: false }
    validates :profile, presence: true, length: { maximum: 255 }, allow_nil: true
    validates :area, presence: true, length: { maximum: 20 }, allow_nil: true
    validates :HomePage, allow_blank: true, length: { maximum: 100 }
    validates :birth, presence: true, allow_nil: true
    validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
    has_secure_password
    has_many :microposts
    has_many :following_relationships, class_name:  "Relationship",
                                     foreign_key: "follower_id",
                                     dependent:   :destroy
    has_many :following_users, through: :following_relationships, source: :followed
    has_many :follower_relationships, class_name:  "Relationship",
                                    foreign_key: "followed_id",
                                    dependent:   :destroy
    has_many :follower_users, through: :follower_relationships, source: :follower
    
    # has_many :retweeted_users, class_name: "users",
    #                             foreign_key: "retweets_microposts_id"
    # belongs_to :retweet_user, class_name: "users",
    #                             foreign_key: "retweets_microposts_id"
    
  # 他のユーザーをフォローする
  def follow(other_user)
    following_relationships.find_or_create_by(followed_id: other_user.id)
  end

  # フォローしているユーザーをアンフォローする
  def unfollow(other_user)
    following_relationship = following_relationships.find_by(followed_id: other_user.id)
    following_relationship.destroy if following_relationship
  end

  # あるユーザーをフォローしているかどうか？
  def following?(other_user)
    following_users.include?(other_user)
  end
    validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
    
  def feed_items
    Micropost.where(user_id: following_user_ids + [self.id])
  end
end