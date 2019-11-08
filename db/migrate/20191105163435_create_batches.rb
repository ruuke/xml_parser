class CreateBatches < ActiveRecord::Migration[5.2]
  def up
    create_table :batches, id: false do |t|
      t.integer :batch_id, primary_key: true, comment: 'Номер списка посылок'
      t.string :guid, null: false, comment: 'Уникальный номер из файла xml'
      t.datetime :creation_date, null: false, comment: 'Дата создания списка посылок'

      t.timestamps
    end

    execute <<-SQL
      ALTER TABLE batches
        ADD CONSTRAINT batch_id_size
        CHECK (batch_id > 999999 AND batch_id < 10000000);
    SQL
  end

  def down
    drop_table :batches
  end
end
