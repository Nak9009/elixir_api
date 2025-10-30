defmodule ElixirApi.Accounts.UserTest do
  use ElixirApi.DataCase, async: true
  alias ElixirApi.Accounts.User

  describe "changeset/2" do
    test "valid attributes produce a valid changeset" do
      attrs = %{
        name: "Alice",
        email: "alice@example.com",
        age: 25,
        password: "secret123"
      }

      changeset = User.changeset(%User{}, attrs)
      assert changeset.valid?
      assert get_change(changeset, :password_hash)
    end

    test "invalid email is rejected" do
      attrs = %{
        name: "Alice",
        email: "invalid_email",
        age: 25,
        password: "secret123"
      }

      changeset = User.changeset(%User{}, attrs)
      refute changeset.valid?
      assert %{email: ["has invalid format"]} = errors_on(changeset)
    end

    test "age outside range is rejected" do
      attrs = %{
        name: "Alice",
        email: "alice@example.com",
        age: 150,
        password: "secret123"
      }

      changeset = User.changeset(%User{}, attrs)
      refute changeset.valid?
      assert %{age: ["must be less than or equal to 120"]} = errors_on(changeset)
    end

    test "missing required fields are rejected" do
      changeset = User.changeset(%User{}, %{})
      refute changeset.valid?
      assert %{name: ["can't be blank"], email: ["can't be blank"]} = errors_on(changeset)
    end
  end
end
