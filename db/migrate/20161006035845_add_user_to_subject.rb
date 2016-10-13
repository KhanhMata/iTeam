class AddUserToSubject < ActiveRecord::Migration[5.0]
  def change
    add_reference :subjects, :user, foreign_key: true
  end
end
