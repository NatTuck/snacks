
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

## API Examples

### Authentication

Register a new user:
```bash
curl -X POST http://localhost:4000/api/v1/auth/register \
  -H "Content-Type: application/json" \
  -d '{"user": {"email": "user@example.com", "password": "password123"}}'
```

Login and get a JWT token:
```bash
curl -X POST http://localhost:4000/api/v1/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email": "user@example.com", "password": "password123"}'
```

### Foods

List all foods:
```bash
curl -X GET http://localhost:4000/api/v1/foods \
  -H "Authorization: Bearer YOUR_JWT_TOKEN" \
  -H "Content-Type: application/json"
```

Create a new food:
```bash
curl -X POST http://localhost:4000/api/v1/foods \
  -H "Authorization: Bearer YOUR_JWT_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "food": {
      "name": "Apple",
      "cals_per_serv": 95,
      "serv_size": 1,
      "serv_unit": "medium apple",
      "car_per_serv": 25,
      "fat_per_serv": 0,
      "pro_per_serv": 0,
      "fib_per_serv": 4
    }
  }'
```

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
