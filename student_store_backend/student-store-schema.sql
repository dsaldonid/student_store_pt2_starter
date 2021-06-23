CREATE TABLE users (
  id          SERIAL PRIMARY KEY,
  -- name        TEXT NOT NULL,
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

CREATE TABLE orders (
  id           SERIAL PRIMARY KEY,
  customer_id  INTEGER NOT NULL,
  created_at   TIMESTAMP NOT NULL DEFAULT NOW(),
  FOREIGN KEY  (customer_id) REFERENCES users(id) ON DELETE CASCADE
);

-- shows alternative way to reference to other tables
-- have composite primary key to ensure that the same product_id can
-- show up in one order_id 
CREATE TABLE order_details (
  order_id     INTEGER NOT NULL REFERENCES orders(id) ON DELETE CASCADE,
  product_id   INTEGER NOT NULL REFERENCES products(id) ON DELETE CASCADE,
  quantity     INTEGER DEFAULT 1,
  discount     INTEGER,
  PRIMARY KEY  (order_id,product_id)
);
