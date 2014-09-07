class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.references :user, index: true
      t.references :game, index: true
      t.string :team
    end
  end
end
