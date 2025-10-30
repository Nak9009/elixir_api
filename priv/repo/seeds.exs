# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     ElixirApi.Repo.insert!(%ElixirApi.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias ElixirApi.Repo
alias ElixirApi.Accounts.User

users = [
  %{
    name: "Alice Johnson",
    email: "alice@example.com",
    age: 28
  },
  %{
    name: "Bob Smith",
    email: "bob@example.com",
    age: 35
  },
  %{
    name: "Charlie Brown",
    email: "charlie@example.com",
    age: 22
  }
]

Enum.each(users, fn user_attrs ->
  %User{}
  |> User.changeset(user_attrs)
  |> Repo.insert!()
end)

IO.puts("Seeded #{length(users)} users")
