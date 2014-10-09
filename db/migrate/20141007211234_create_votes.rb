class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references :nomination, index: true
      t.references :player
      t.boolean :pass
      t.timestamps
    end
  end
end
