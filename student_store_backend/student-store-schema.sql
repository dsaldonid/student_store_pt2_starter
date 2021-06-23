CREATE TABLE users (
  id          SERIAL PRIMARY KEY,
  NAME        TEXT NOT NULL,
  password    TEXT NOT NULL,
  username    TEXT NOT NULL UNIQUE,
  email       TEXT NOT NULL UNIQUE CHECK (POSITION('@' IN email) > 1),
  is_admin    BOOLEAN NOT NULL DEFAULT FALSE,
  created_at  TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE products (
  id           SERIAL PRIMARY KEY,
  NAME         TEXT NOT NULL,
  category     TEXT NOT NULL,
  image        TEXT NOT NULL UNIQUE,
  description  TEXT NOT NULL UNIQUE,
  price        BIGINT NOT NULL
);
