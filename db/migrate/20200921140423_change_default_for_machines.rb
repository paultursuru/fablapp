class ChangeDefaultForMachines < ActiveRecord::Migration[6.0]
  def change
    change_column_default :machines, :visible, from: nil, to: false
  end
end
