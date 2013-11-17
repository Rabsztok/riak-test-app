class RiakAudio
  include Ripple::Document
  property :name,                    String,  :presence => true
  property :attachment_file_name,    String,  :presence => true
  property :attachment_file_size,    Integer, :presence => true
  property :attachment_content_type, String,  :presence => true
  property :attachment_content_type, String,  :presence => true
  property :created_at,              Time,    :default => proc { Time.now }

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
   :path => ":id_:filename"
end
