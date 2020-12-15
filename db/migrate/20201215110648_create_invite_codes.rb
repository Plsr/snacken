class CreateInviteCodes < ActiveRecord::Migration[6.1]
  def change
    create_table :invite_codes do |t|
      t.string :code
      t.datetime :used_at

      t.timestamps
    end
  end
end
