class CreateCourseCompetences < ActiveRecord::Migration[7.0]
  def change
    create_table :course_competences do |t|
      t.references :course, null: false, foreign_key: true, type: :uuid
      t.references :competence, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end

    add_index :course_competences, [:course_id, :competence_id], unique: true
  end
end
