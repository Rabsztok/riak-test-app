class CreateRiakAudios < ActiveRecord::Migration
  def change
    create_table :riak_audios do |t|
      t.string :name
      t.string :attachment

      t.timestamps
    end
  end
end
