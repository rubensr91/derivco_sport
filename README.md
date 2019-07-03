# DerivcoSport

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix

git clone ...
cd into the folder
mix deps.get
mix compile
iex -S mix

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