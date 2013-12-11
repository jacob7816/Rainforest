class CreateTranscripts < ActiveRecord::Migration
  def change
    create_table :transcripts do |t|
      t.string :stock_symbol
      t.float :grade
      t.text :content

      t.timestamps
    end
  end
end
