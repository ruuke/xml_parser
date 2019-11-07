class CreateInvoices < ActiveRecord::Migration[5.2]
  def change
    create_table :invoices, id: false do |t|
      t.integer :invoice_operation_number, primary_key: true
      t.integer :company_code, null: false
      t.datetime :invoice_operation_date, null: false, comment: 'Дата отправки посылки'
      t.references :batch_id,  references: :batches

      t.timestamps
    end
  end
end
