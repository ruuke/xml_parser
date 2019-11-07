class CreateParcels < ActiveRecord::Migration[5.2]
  def change
    create_table :parcels, id: false do |t|
      t.string :parcel_code, primary_key: true
      t.string :title, default: "Item_#{1000000}"

      t.timestamps
    end
  end
end
