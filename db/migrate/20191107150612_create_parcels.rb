class CreateParcels < ActiveRecord::Migration[5.2]
  def change
    create_table :parcels, id: false do |t|
      t.string :code, primary_key: true
      t.string :title, default: "Item_#{1000000}"
      t.decimal :parcel_price, precision: 7, scale: 2, null: false, comment: 'Цена единицы товара для покупателя'

      t.timestamps
    end
  end
end
