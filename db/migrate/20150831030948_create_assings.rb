class CreateAssings < ActiveRecord::Migration
  def change
    create_table :assings do |t|
      t.references :mission, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
