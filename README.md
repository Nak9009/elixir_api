# Elixir API Documentation

## Project: `elixir_api`

**Description:**

A simple API built with Phoenix and Elixir to manage users. Supports basic CRUD operations.

**Base URL:**

```
http://localhost:4000/api
```

---

## Schema: Users

| Field | Type | Description |
| --- | --- | --- |
| `id` | UUID | Primary key |
| `name` | string | User's name (required) |
| `email` | string | User's email (unique) |
| `age` | integer | User's age |
| `inserted_at` | datetime | Timestamp of creation |
| `updated_at` | datetime | Timestamp of last update |

---

## Endpoints

### 1. List Users

- **URL:** `/users`
- **Method:** `GET`
- **Description:** Get a list of all users.
- **Response:**

```json
{
  "data": [
    {
      "id": "uuid",
      "name": "John Doe",
      "email": "john@example.com",
      "age": 30,
      "inserted_at": "2025-10-30T10:00:00Z",
      "updated_at": "2025-10-30T10:00:00Z"
    }
  ]
}
```

---

### 2. Create User

- **URL:** `/users`
- **Method:** `POST`
- **Body:**

```json
{
  "user": {
    "name": "Jane Doe",
    "email": "jane@example.com",
    "age": 28
  }
}
```

- **Response:**

```json
{
  "data": {
    "id": "uuid",
    "name": "Jane Doe",
    "email": "jane@example.com",
    "age": 28,
    "inserted_at": "2025-10-30T10:05:00Z",
    "updated_at": "2025-10-30T10:05:00Z"
  }
}
```

---

### 3. Show User

- **URL:** `/users/:id`
- **Method:** `GET`
- **Response:**

```json
{
  "data": {
    "id": "uuid",
    "name": "Jane Doe",
    "email": "jane@example.com",
    "age": 28,
    "inserted_at": "2025-10-30T10:05:00Z",
    "updated_at": "2025-10-30T10:05:00Z"
  }
}
```

---

### 4. Update User

- **URL:** `/users/:id`
- **Method:** `PATCH`
- **Body:**

```json
{
  "user": {
    "age": 29
  }
}
```

- **Response:**

```json
{
  "data": {
    "id": "uuid",
    "name": "Jane Doe",
    "email": "jane@example.com",
    "age": 29,
    "inserted_at": "2025-10-30T10:05:00Z",
    "updated_at": "2025-10-30T10:10:00Z"
  }
}
```

---

### 5. Delete User

- **URL:** `/users/:id`
- **Method:** `DELETE`
- **Response:** `204 No Content`

---

## Setup Instructions

1. Install dependencies:

```bash
mix deps.get
```

1. Setup database:

```bash
mix ecto.create
mix ecto.migrate
```

1. Start the server:

```bash
mix phx.server
```

1. Access API:

```
http://localhost:4000/api/users
```

---

## Notes

- Emails must be unique.
- `name` and `email` are required fields.
- API only returns JSON responses.
- UUIDs are used for user IDs.
---
Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

* Official website: https://www.phoenixframework.org/
* Guides: https://hexdocs.pm/phoenix/overview.html
* Docs: https://hexdocs.pm/phoenix
* Forum: https://elixirforum.com/c/phoenix-forum
* Source: https://github.com/phoenixframework/phoenix