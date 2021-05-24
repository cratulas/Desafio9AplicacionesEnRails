class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.integer :status, default: 0
      t.date :loan_date
      t.date :return_date

      t.timestamps
    end
  end
end
