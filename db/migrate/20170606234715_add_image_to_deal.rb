class AddImageToDeal < ActiveRecord::Migration
  def change
    add_attachment :deals, :image
  end
end
