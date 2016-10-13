class CreateExamQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :exam_questions do |t|
      t.boolean :is_correct
      t.text :content
      t.references :exam, foreign_key: true
      t.references :question, foreign_key: true

      t.timestamps
    end
  end
end
