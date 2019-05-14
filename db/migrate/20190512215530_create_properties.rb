class CreateProperties < ActiveRecord::Migration
  def change
  	create_table :properties do |t|
  		t.string :name
  		t.string :address
  		t.string :tenant_name
  		t.string :tenant_email
  		t.string :tenant_phone_number
  		t.float :security_deposit
  		t.float :rent
  		t.string :lease_starting_date
  		t.string :lease_ending_date
  		t.integer :user_id
  	end
  end
end
