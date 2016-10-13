class CreateQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :questions do |t|
      t.text :content
      t.integer :answer_type
      t.integer :status
      t.references :user, foreign_key: true
      t.references :subject, foreign_key: true

      t.timestamps null: false
    end
  end
end
