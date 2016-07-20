class CreateUserHobbies < ActiveRecord::Migration
  def change
    create_table :user_hobbies do |t|
      t.references :user, index: true, foreign_key: true
      t.references :hobby, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
