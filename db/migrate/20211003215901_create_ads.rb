# frozen_string_literal: true

class CreateAds < ActiveRecord::Migration[6.1]
  def change
    create_table :ads do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.string :city, null: false
      t.float :lat
      t.float :lon
      t.integer :user_id, null: false, index: true
      t.timestamps
    end
  end
end
