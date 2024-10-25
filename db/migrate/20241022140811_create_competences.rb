class CreateCompetences < ActiveRecord::Migration[7.0]
  def change
    create_table :competences, id: :uuid, default: -> { 'gen_random_uuid()' } do |t|
      t.string :name, null: false, index: { unique: true }

      t.timestamps
    end
  end
end
