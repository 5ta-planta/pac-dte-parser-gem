Gem::Specification.new do |s|
  s.name        = 'pac_dte_parser'
  s.version     = '0.0.156'
  s.summary     = "Parseo de XML"
  s.description = "Parser de XML PAC Panama"
  s.authors     = ["Team GFIP"]
  s.email       = 'alopez@fidelis.gt'     
  s.files       = Dir["{lib}/**/*"]
  s.licenses    = ["MIT"]
  s.add_dependency("railties", ">= 4.1.0")
  s.add_dependency("dynamoid")
  s.add_runtime_dependency 'nokogiri', '>= 1.5.1', '!=1.12.3', '!=1.12.2', '!=1.12.1', '!=1.12.0'
end  
