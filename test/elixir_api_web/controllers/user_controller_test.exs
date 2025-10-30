defmodule ElixirApiWeb.UserControllerTest do
  use ElixirApiWeb.ConnCase

  import ElixirApi.AccountsFixtures
  alias ElixirApi.Accounts.User

  @create_attrs %{
    name: "Some Name",
    email: "user@example.com",
    age: 30,
    password: "secret123"
  }
  @update_attrs %{
    name: "Updated Name",
    email: "updated@example.com",
    age: 35,
    password: "newsecret123"
  }
  @invalid_attrs %{name: nil, email: nil, age: nil, password: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all users", %{conn: conn} do
      conn = get(conn, Routes.user_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create user" do
    test "renders user when data is valid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.user_path(conn, :show, id))
      response = json_response(conn, 200)["data"]

      assert response["id"] == id
      assert response["name"] == "Some Name"
      assert response["email"] == "user@example.com"
      assert response["age"] == 30
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update user" do
    setup [:create_user]

    test "renders user when data is valid", %{conn: conn, user: %User{id: id}} do
      conn = put(conn, Routes.user_path(conn, :update, user), user: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.user_path(conn, :show, id))
      response = json_response(conn, 200)["data"]

      assert response["id"] == id
      assert response["name"] == "Updated Name"
      assert response["email"] == "updated@example.com"
      assert response["age"] == 35
    end

    test "renders errors when data is invalid", %{conn: conn, user: user} do
      conn = put(conn, Routes.user_path(conn, :update, user), user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete user" do
    setup [:create_user]

    test "deletes chosen user", %{conn: conn, user: user} do
      conn = delete(conn, Routes.user_path(conn, :delete, user))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.user_path(conn, :show, user))
      end
    end
  end

  describe "login" do
    setup [:create_user]

    test "successfully returns a JWT token", %{conn: conn, user: user} do
      conn = post(conn, Routes.user_path(conn, :login), %{
        "email" => user.email,
        "password" => "secret123"
      })

      response = json_response(conn, 200)
      assert is_binary(response["token"])
    end

    test "fails with invalid credentials", %{conn: conn, user: user} do
      conn = post(conn, Routes.user_path(conn, :login), %{
        "email" => user.email,
        "password" => "wrongpassword"
      })

      response = json_response(conn, 401)
      assert response["error"] != nil
    end
  end

  describe "profile" do
    setup [:create_user]

    test "returns user info with valid JWT", %{conn: conn, user: user} do
      {:ok, token, _} = ElixirApi.Guardian.encode_and_sign(user)

      conn =
        conn
        |> put_req_header("authorization", "Bearer #{token}")
        |> get(Routes.user_path(conn, :profile))

      response = json_response(conn, 200)

      assert response["email"] == user.email
      assert response["role"] == user.role
      assert response["name"] == user.name
    end

    test "fails without JWT", %{conn: conn} do
      conn = get(conn, Routes.user_path(conn, :profile))
      response = json_response(conn, 401)
      assert response["error"] != nil
    end
  end

  # Helper to create a user fixture
  defp create_user(_) do
    user = user_fixture(%{role: "admin"})
    %{user: user}
  end
end
