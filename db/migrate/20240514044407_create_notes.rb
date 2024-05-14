# frozen_string_literal: true

class CreateNotes < ActiveRecord::Migration[7.1]
  def change
    create_table :notes do |t|
      t.string :content, null: false
      t.timestamps
    end
  end
end
