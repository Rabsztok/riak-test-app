class CreateMongodbAudios < ActiveRecord::Migration
  def change
    create_table :mongodb_audios do |t|
      t.string :name
      t.string :attachment

      t.timestamps
    end
  end
end
