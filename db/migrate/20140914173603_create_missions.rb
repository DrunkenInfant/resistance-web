class CreateMissions < ActiveRecord::Migration
  def change
    create_table :missions do |t|
      t.references :game, index: true
      t.integer :index
      t.integer :nbr_participants
      t.integer :nbr_fails_required, default: 1
    end
  end
end
