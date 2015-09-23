class CreateAssigns < ActiveRecord::Migration
  def change
    create_table :assigns do |t|
      t.references :mission, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
