class CreateBetaCandidates < ActiveRecord::Migration[6.1]
  def change
    create_table :beta_candidates do |t|
      t.belongs_to :user
      t.string :email
      t.datetime :confirmed_at
      t.string :confirmation_token, null: false
      t.datetime :converted_at

      t.timestamps
    end
  end
end
