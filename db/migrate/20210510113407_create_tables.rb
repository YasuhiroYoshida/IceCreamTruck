class CreateTables < ActiveRecord::Migration[6.1]
  def change
    create_table :trucks do |t|
      t.string :name, null: false
      t.timestamps
    end

    create_table :flavors do |t|
      t.string :name, null: false, index: true
      t.references :truck, null: false, foreign_key: true
      t.timestamps
    end

    create_table :products do |t|
      t.string :type
      t.references :flavor, foreign_key: true
      t.integer :price, null: false, default: 0
      t.integer :sold, null: false, default: 0
      t.integer :remaining, null: false, default: 0
      t.integer :revenue, null: false, default: 0
      t.references :truck, null: false, foreign_key: true
      t.timestamps
    end
    add_index :products, %i[id type]
  end
end
