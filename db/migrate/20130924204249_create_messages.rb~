class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.int :app_id
      t.string :content
      t.string :username
      t.boolean :active

      t.timestamps
    end
  end
end
