class AddRetweetsMicropostsIdToMicropost < ActiveRecord::Migration
  def change
    add_column :microposts, :retweets_microposts_id, :integer
  end
end
