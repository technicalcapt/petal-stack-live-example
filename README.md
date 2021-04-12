# How to run project

1. Install docker (https://docs.docker.com/engine/install/) and docker-compose
2. Create `.env` file to add your environment variable to the following
```
DATABASE_URL=postgres://postgres:postgres@db:5432/peta_stack_example_dev
SECRET_KEY_BASE=YOUR_SECRET_KEY_BASE
```
You can generate secret key by running: `mix phx.gen.secret`

3. Move to the project root (current directory) and execute below command in the shell
`$ docker-compose up`
3. Navigate to localhost:4001 in the browser

# You can find live app via Heroku

https://polar-fortress-26763.herokuapp.com/
