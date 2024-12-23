class CreateKernelCommands < ActiveRecord::Migration[8.0]
  def change
    create_table :kernel_commands do |t|
      t.references :content, null: false, foreign_key: { on_delete: :cascade }
      t.text :body

      t.timestamps
    end
  end
end
