class AddStatusToReaders < ActiveRecord::Migration[6.0]
  def change
    change_table :readers do |t|
      t.column :status, :string, default: "pending"
    end
  end
end
