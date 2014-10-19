class CreateMissionResults < ActiveRecord::Migration
  def change
    create_table :mission_results do |t|
      t.references :mission, index: true
      t.references :player
      t.boolean :success
      t.timestamps
    end
  end
end
