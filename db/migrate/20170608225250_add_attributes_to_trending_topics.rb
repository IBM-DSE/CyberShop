class AddAttributesToTrendingTopics < ActiveRecord::Migration
  def change
    add_column :trending_topics, :frequency, :integer
    add_column :trending_topics, :aphone, :integer
    add_column :trending_topics, :sphone, :integer
  end
end
