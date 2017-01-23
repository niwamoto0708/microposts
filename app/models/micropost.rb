class Micropost < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  has_many :retweeted_microposts, class_name:  "Micropost",
                                     foreign_key: "retweets_microposts_id"
  belongs_to :retweet_micropost, class_name: "Micropost",
                                     foreign_key: "retweets_microposts_id"
  #def retweet_user
  #  retweet_micropost.user
  #end
end