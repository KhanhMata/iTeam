class CreateAnswers < ActiveRecord::Migration[5.0]
  def change
    create_table :answers do |t|
      t.string :content
      t.boolean :is_correct, default: false
      t.references :question, foreign_key: true

      t.timestamps
    end
  end
end