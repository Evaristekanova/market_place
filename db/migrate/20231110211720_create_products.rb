class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.decimal :price
      t.string :name
      t.string :description
      t.boolean :published, :default => true
      #Ex:- :default =>''
      

      t.timestamps
    end
  end
end
