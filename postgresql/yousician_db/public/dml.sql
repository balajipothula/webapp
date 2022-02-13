-- insert record into the Song table.
INSERT INTO yousician_db.public."Song"(
  "artist",
  "title",
  "difficulty",
  "level",
  "released"
)
VALUES(
  'The Yousicians',
  'A New Kennel',
  9.9,
  9,
  '2022-02-09'
);

-- insert record into the Rating table.
INSERT INTO yousician_db.public."Rating"(
  "id",
  "rate"
)
VALUES(
  34,
  2
);
