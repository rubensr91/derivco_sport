 # DerivcoSport
 * This is my test to Derivco Sport
 * I have make an API with Plug to offer games results
 * Follow the steps to install my application 
  or if you know docker you can download my repo --> docker pull rubensr91/laliga

 # HOW TO
 * git clone https://github.com/rubensr91/derivco_sport.git
 * cd derivco_sport/
 * mix deps.get
 * mix compile
 * iex -S mix
 * To see if everything run ok, the next step must to return "pong" in the browser
 * http://localhost:4001/ping 
 * To filter results by season and/or division
 * http://localhost:4001/api/laliga?season=201617&div=SP1
 * To see metrics of the aplication 
 * http://localhost:4001/metrics
 * To see version github
 * http://localhost:4001/version
 * Run mix run --no-halt and next go to http://127.0.0.1:8080/ to see web machine working

## COVERALLS
 * mkdir -p priv/repo/migrations
 * MIX_ENV=test mix coveralls

## DOCKER
 * sudo docker pull rubensr91/laliga
 * sudo docker build --tag=rubensr91/laliga .

## DOCKER COMPOSE
 * run sudo docker-compose up
