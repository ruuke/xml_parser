class CreateInvoices < ActiveRecord::Migration[5.2]
  def up
    create_table :invoices, id: false do |t|
      t.integer :invoice_operation_number, primary_key: true
      t.integer :company_code, null: false
      t.datetime :invoice_operation_date, null: false, comment: 'Дата отправки посылки'
      t.references :batch_id,  references: :batches, null: false

      t.timestamps
    end

    rename_column :invoices, :batch_id_id, :batch_id
    add_foreign_key :invoices, :batches, column: 'batch_id', primary_key: 'id'

    execute <<-SQL
      ALTER TABLE invoices
        ADD CONSTRAINT invoice_operation_number_size
        CHECK (invoice_operation_number > 1 AND invoice_operation_number < 1000000000);

      ALTER TABLE invoices
        ADD CONSTRAINT company_code_size
        CHECK (company_code > 999 AND company_code < 10000);
    SQL
  end

  def down
    drop_table :invoices
  end
end
