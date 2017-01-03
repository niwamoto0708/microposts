class AddProfileAreaHomePageBirthToUser < ActiveRecord::Migration
  def change
    add_column :users, :profile, :text
    add_column :users, :area, :string
    add_column :users, :HomePage, :string
    add_column :users, :birth, :datetime
  end
end
