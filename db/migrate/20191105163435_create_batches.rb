class CreateBatches < ActiveRecord::Migration[5.2]
  def change
    create_table :batches, id: false do |t|
      t.integer :batch_id, primary_key: true, comment: 'Номер списка посылок'
      t.string :guid, null: false, comment: 'Уникальный номер из файла xml'
      t.datetime :creation_date, null: false, comment: 'Дата создания списка посылок'

      t.timestamps
    end
  end
end
