class CreateRiakAudios < ActiveRecord::Migration
  def change
    create_table :riak_audios do |t|
      t.string :name
      t.string :attachment_file_name
      t.string :attachment_content_type
      t.string :attachment_file_size
      t.timestamps
    end
  end
end
