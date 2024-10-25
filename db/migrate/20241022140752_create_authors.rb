class CreateAuthors < ActiveRecord::Migration[7.0]
  def change
    create_table :authors, id: :uuid, default: -> { 'gen_random_uuid()' } do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
