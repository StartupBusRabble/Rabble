class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :venue
      t.string :address
      t.string :date
    end
  end
end
