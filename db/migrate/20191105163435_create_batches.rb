class CreateBatches < ActiveRecord::Migration[5.2]
  def change
    create_table :batches do |t|
      t.text :guid, null: false, unique: true, comment: 'Уникальный номер из файла xml'
      t.integer :batch_id, null: false, limit: 7, unique: true, comment: 'Номер списка посылок'
      t.datetime :creation_date, null: false, comment: 'Дата создания списка посылок'

      t.timestamps
    end

    add_index :batches, :guid
    add_index :batches, :batch_id
  end
end
