class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_enum :status, [
      'out_of_stock',
      'in_stock',
      'running_low'
    ]

    create_table :products do |t|
      t.string :name, null: false
      t.decimal :price, precision: 8, scale: 2, null: false
      t.enum(
        :status,
        enum_type: :status,
        default: :in_stock,
        null: false
      )

      t.timestamps
    end
  end
end
