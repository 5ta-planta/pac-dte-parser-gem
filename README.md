# pac-dte-parser-gem

### Agregar a gemfile:
gem 'pac_dte_parser', git: 'https://github.com/5ta-planta/pac-dte-parser-gem.git', branch: "main"
### Usar en código

def probar

    json = File.open("archivo").read
    
    v = ValidaDte.new(json)
    
    r = v.cargar  
    
    return v.validar     
end


