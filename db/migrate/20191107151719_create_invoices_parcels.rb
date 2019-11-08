class CreateInvoicesParcels < ActiveRecord::Migration[5.2]
  def up
    create_table :invoices_parcels do |t|
      t.integer :item_qty, null: false, comment: 'Количество товара'
      t.references :invoice_operation_number, references: :invoices
      t.references :parcel_code, references: :parcels

      t.timestamps
    end

    execute <<-SQL
      ALTER TABLE invoices_parcels
        ADD CONSTRAINT item_qty_size
        CHECK (item_qty > 0 AND item_qty <= 50);
    SQL
  end

  def down
    drop_table :invoices_parcels
  end
end
