class RiakAudio < ActiveRecord::Base
  attr_accessible :name, :attachment
  attr_accessor :attachment_file_name

  has_attached_file :attachment,
    :storage => :riak,
    :riak_hosts => [
      {:host => '127.0.0.1', :port => '10018'},
      {:host => '127.0.0.1', :port => '10028'},
      {:host => '127.0.0.1', :port => '10038'},
      {:host => '127.0.0.1', :port => '10048'},
      {:host => '127.0.0.1', :port => '10058'}
    ],
    :riak_bucket => 'audios',
    :riak_endpoint => 'http://127.0.0.1:10018/riak',
    :path => ":id_:name.:extension"
end
