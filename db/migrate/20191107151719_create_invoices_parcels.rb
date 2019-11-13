class CreateInvoicesParcels < ActiveRecord::Migration[5.2]
  def up
    create_table :invoices_parcels do |t|
      t.integer :item_qty, null: false, comment: 'Количество товара'

      t.references :invoice_invoice_operation_number_id,
                   references: :invoices,
                   null: false,
                   index: { name: :index_invoce_invoices_parcel }

      t.references :parcel_code_id,
                   references: :parcels,
                   null: false,
                   index: { name: :index_parcel_invoices_parcel }

      t.timestamps
    end

    execute <<-SQL
      ALTER TABLE invoices_parcels
        ALTER COLUMN parcel_code_id_id SET DATA TYPE varchar(15);
    SQL

    rename_column :invoices_parcels, :invoice_invoice_operation_number_id_id, :invoice_number
    rename_column :invoices_parcels, :parcel_code_id_id, :parcel_code

    add_foreign_key :invoices_parcels, :invoices, column: 'invoice_number', primary_key: 'invoice_operation_number'
    add_foreign_key :invoices_parcels, :parcels, column: 'parcel_code', primary_key: 'code'

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
