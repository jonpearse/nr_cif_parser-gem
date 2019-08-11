Gem::Specification.new do |spec|
  
  spec.name         = 'nr_cif_parser'
  spec.summary      = 'Decoder for Network Rail’s ITPS Schedule files in CIF format.'
  spec.license      = 'MIT'

  spec.authors      = 'Jon Pearse'
  spec.email        = 'hello@jonpearse.net'
  spec.homepage     = 'https://github.com/jonpearse/nr_cif_parser-gem'
  
  spec.version      = '1.0.0.pre'
  spec.files        = `git ls-files`.split($\)
  
  spec.add_development_dependency( 'minitest', '~> 5.11.3' )
  
end