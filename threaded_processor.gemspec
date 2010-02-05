spec = Gem::Specification.new do |s|
  s.name = 'threaded_processor'
  s.version = '0.1.2'
  s.summary = "Threaded processor with specifiable thread pool size."
  s.description = %{A simple wrapper for Ruby Threads and SizedQueue.}
  s.files = Dir['lib/*.rb']
  s.require_path = 'lib'
  s.has_rdoc = false
  s.author = "Patrick Morgan"
  s.email = "patrick@patrick-morgan.net"
  s.homepage = "http://www.patrick-morgan.net"
end
