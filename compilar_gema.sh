echo 'iniciando compilacion version $1'  
gem build pac_dte_parser.gemspec
gem install ./pac_dte_parser-0.0.171.gem
git add . 
git commit -am "Compilando nueva version "  
#git pull origin main 
#git push origin main 

