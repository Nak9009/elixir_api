alias ElixirApi.Repo
alias ElixirApi.Accounts.User

phase1_users = [
  %{
    name: "Admin User",
    email: "admin@example.com",
    age: 30,
    role: "admin",
    password: "admin123"
  },
  %{
    name: "Regular User",
    email: "user@example.com",
    age: 25,
    role: "user",
    password: "user123"
  }
]

Enum.each(phase1_users, fn user_attrs ->
  password_hash = Bcrypt.hash_pwd_salt(user_attrs.password)


  %User{}
  |> User.changeset(Map.put(user_attrs, :password_hash, password_hash))
  |> Repo.insert!()
end)

IO.puts("Phase 1 users seeded successfully!")
