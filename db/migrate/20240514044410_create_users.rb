# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :username, null: false
      t.timestamps
    end
    add_index :users, [:username], unique: true
    add_reference :notes, :user, foreign_key: true
  end
end
