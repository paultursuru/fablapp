class CreateMachines < ActiveRecord::Migration[6.0]
  def change
    create_table :machines do |t|
      t.string :name
      t.string :description
      t.boolean :visible

      t.timestamps
    end
  end
end
