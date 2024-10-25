class CreateCourses < ActiveRecord::Migration[7.0]
  def change
    create_table :courses, id: :uuid, default: -> { 'gen_random_uuid()' } do |t|
      t.string :name, null: false
      t.references :author, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end

    add_index :courses, [:author_id, :name], unique: true
  end
end
