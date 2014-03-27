class CreateEvent < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.column :description, :string
      t.column :location, :string
      t.column :start, :datetime
      t.column :finish, :datetime
    end
  end
end
