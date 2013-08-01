class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.string   :stripe_customer_token
      t.interger :balance
      t.timestamps
  end
end
