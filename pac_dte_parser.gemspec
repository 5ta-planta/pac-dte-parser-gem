Gem::Specification.new do |s|
  s.name        = 'pac_dte_parser'
  s.version     = '0.0.2'
  s.summary     = "Parseo de XML"
  s.description = "Parser de XML PAC Panama"
  s.authors     = ["Team GFIP"]
  s.email       = 'alopez@fidelis.gt'     
  s.files       = Dir["{config,lib,xml_demo}/**/*"]
  s.licenses    = ["MIT"]

  s.add_dependency("railties", ">= 4.1.0")
end  
