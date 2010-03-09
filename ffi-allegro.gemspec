
$gemspec = Gem::Specification.new do |s|
  s.name = 'ffi-allegro'
  s.version = '0.2'

  s.authors = ['Nicolas Martyanoff']
  s.email = 'khaelin@gmail.com'
  s.homepage = 'http://github.com/galdor/ffi-allegro'

  s.summary = "FFI bindings to Allegro"
  s.description = <<EOF
ffi-allegro is a binding to the Allegro multimedia libraray.
EOF

  s.files = Dir[
      'COPYING',
      'README.mkd',
      'lib/**/*.rb',
      'examples/*.rb',
  ]

  s.required_ruby_version = '>= 1.9'

  s.add_dependency( 'ffi', '>=0.6.0pre' )
end
