class AddAttributesToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :gender, :string
    add_column :customers, :age_group, :string
    add_column :customers, :education, :string
    add_column :customers, :profession, :string
    add_column :customers, :income, :integer
    add_column :customers, :switcher, :integer
    add_column :customers, :last_purchase, :integer
    add_column :customers, :annual_spend, :integer
  end
end
