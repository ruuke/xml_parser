class CreateInvoicesParcels < ActiveRecord::Migration[5.2]
  def up
    create_table :invoices_parcels do |t|
      t.integer :item_qty, null: false, comment: 'Количество товара'
      t.decimal :parcel_price, precision: 7, scale: 2, null: false, comment: 'Цена единицы товара для покупателя'

      t.references :invoce_invoice_operation_number_id,
                   references: :invoices,
                   null: false,
                   index: { name: :index_invoce_invoices_parcel }

      t.references :parcel_parcel_code_id,
                   references: :parcels,
                   null: false,
                   index: { name: :index_parcel_invoices_parcel }

      t.timestamps
    end

    execute <<-SQL
      ALTER TABLE invoices_parcels
        ALTER COLUMN parcel_parcel_code_id_id SET DATA TYPE varchar(15);
    SQL

    rename_column :invoices_parcels, :invoce_invoice_operation_number_id_id, :invoice_id
    rename_column :invoices_parcels, :parcel_parcel_code_id_id, :parcel_id

    add_foreign_key :invoices_parcels, :invoices, column: 'invoice_id', primary_key: 'invoice_operation_number'
    add_foreign_key :invoices_parcels, :parcels, column: 'parcel_id', primary_key: 'parcel_code'

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
