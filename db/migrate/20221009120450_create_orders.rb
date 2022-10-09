class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_enum :order_status, [
      'new_order',
      'packaging',
      'deliver_in_process',
      'done'
    ]

    create_table :orders do |t|
      t.enum(
        :status,
        enum_type: :order_status,
        default: :new_order,
        null: false
      )

      t.timestamps
    end
  end
end
