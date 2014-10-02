class CreateNominations < ActiveRecord::Migration
  def change
    create_table :nominations do |t|
      t.references :mission, index: true
      t.timestamps
    end
    create_table :nominations_players do |t|
      t.references :nomination
      t.references :player
    end
  end
end
