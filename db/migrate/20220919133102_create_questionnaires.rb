class CreateQuestionnaires < ActiveRecord::Migration[6.1]
  def change
    create_table :questionnaires do |t|
      t.string :reference
      t.jsonb :content

      t.timestamps
    end
  end
end
