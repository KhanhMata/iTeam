class CreateExams < ActiveRecord::Migration[5.0]
  def change
    create_table :exams do |t|
      t.integer :status
      t.datetime :started_at
      t.integer :marks
      t.integer :spent_time
      t.references :user, foreign_key: true
      t.references :subject, foreign_key: true

      t.timestamps null: false
    end
  end
end
