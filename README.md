# DerivcoSport

git clone https://github.com/rubensr91/derivco_sport.git
cd derivco_sport/
mix deps.get
mix compile
iex -S mix
Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.
To see all games results
http://localhost:4000/api/laliga
To see filter results
http://localhost:4000/api/laliga?season=201617

## DIALYZER
 * mix do deps.get, deps.compile, dialyzer --plt
 * mix dialyzer
 
## CREDO
 * mix credo

## COVERALLS
 * mkdir -p priv/repo/migrations
 * MIX_ENV=test mix coveralls

## DOCKER
 * sudo apt-get update && sudo apt-get install \ apt-transport-https \ ca-certificates \ curl \ gnupg-agent \ software-properties-common
 * curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
 * sudo apt-key fingerprint 0EBFCD88
 * sudo add-apt-repository \ "deb [arch=amd64] https://download.docker.com/linux/ubuntu \ $(lsb_release -cs) \ stable"
 * sudo apt-get update
 * sudo apt-get install docker-ce docker-ce-cli containerd.io
 * sudo docker run hello-world
 * docker --version