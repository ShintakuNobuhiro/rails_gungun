class RenameSufficienciesToLevel < ActiveRecord::Migration
  def change
    rename_column :levels, :sufficiencies, :sufficiency
  end
end
