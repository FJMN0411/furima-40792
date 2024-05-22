class RenameSityToCityInAddresses < ActiveRecord::Migration[7.0]
  def change
    rename_column :addresses, :sity, :city
  end
end
