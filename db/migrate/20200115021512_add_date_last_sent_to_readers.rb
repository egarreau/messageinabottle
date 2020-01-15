class AddDateLastSentToReaders < ActiveRecord::Migration[6.0]
  def change
    change_table :readers do |t|
      t.column :date_last_sent, :date
    end
  end
end
