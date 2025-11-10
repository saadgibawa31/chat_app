class CreateMessages < ActiveRecord::Migration[7.2]
  def change
    create_table :messages do |t|

      t.string :message
      t.references :chat, foreign_key: true, null: false

      t.timestamps
    end
  end
end
