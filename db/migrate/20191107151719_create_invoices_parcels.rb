class CreateInvoicesParcels < ActiveRecord::Migration[5.2]
  def change
    create_table :invoices_parcels do |t|
      t.integer :item_qty, null: false, comment: 'Количество товара'
      t.decimal :parcel_price, precision: 7, scale: 2, null: false, comment: 'Цена единицы товара для покупателя'
      t.references :invoice_operation_number, references: :invoices
      t.references :parcel_code, references: :parcels

      t.timestamps
    end
  end
end
