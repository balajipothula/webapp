-- select username and password from the Login table.
CREATE TABLE IF NOT EXISTS yousician_db.public."Song"(
  "songId"     BIGSERIAL                   PRIMARY KEY,
  "artist"     VARCHAR                     NOT NULL,
  "title"      VARCHAR                     NOT NULL,
  "difficulty" REAL                        NOT NULL,
  "level"      SMALLINT                    NOT NULL CHECK(0 < "level"  AND "level" < 26),
  "released"   TIMESTAMP WITHOUT TIME ZONE NOT NULL
);
