# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Fridge.Repo.insert!(%Fridge.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Fridge.Repo
alias Fridge.Users.User

%User{
  email: "alice@example.com",
  password_hash: Argon2.hash_pwd_salt("password")
}
|> Repo.insert!()
