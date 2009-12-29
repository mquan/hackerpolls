class CreatePolls < ActiveRecord::Migration
  def self.up
    create_table :polls do |t|
      t.string :title
      t.integer :score
      t.string :url

      t.timestamps
    end
  end

  def self.down
    drop_table :polls
  end
end
