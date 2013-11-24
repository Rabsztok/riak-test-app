class DropRiakAudios < ActiveRecord::Migration
  def up
    drop_table :riak_audios
  rescue
    puts "   -> RiakAudio is arleady dropped"
  end
end
