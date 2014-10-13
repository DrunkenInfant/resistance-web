class AddKingToGame < ActiveRecord::Migration
  def change
    add_column :games, :king_id, :int
  end
end
