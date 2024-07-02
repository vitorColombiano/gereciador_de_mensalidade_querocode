class CreateBills < ActiveRecord::Migration[7.1]
  def change
    create_table :bills do |t|
      t.integer :amount
      t.date :due_date
      t.string :status
      t.belongs_to :enrollment, null: false, foreign_key: true

      t.timestamps
    end
  end
end
