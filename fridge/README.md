
# Fridge

The backend/API for the Snacks food tracking app

## Schema Thoughts

users:

- email
- password_hash

foods:

- user_id
- name: not null
- calories per serving: not null
- serving size: not null
- serving unit: not null
- carbs per serving
- fat per serving
- protein per serving
- fiber per serving

snacks:

- food_id
- eaten_on

## Phoenix

To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
