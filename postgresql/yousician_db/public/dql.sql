-- select records from the Song table.
SELECT
  "songId"
  "artist",
  "title",
  "difficulty",
  "level",
  "released"
FROM
  yousician_db.public."Song";

-- select particular song record from the Song table.
SELECT
  "songId"
  "artist",
  "title",
  "difficulty",
  "level",
  "released"
FROM
  yousician_db.public."Song"
WHERE
  "songId" = 1;

-- select records from the Rating table.
SELECT
  "id"
  "rate"
FROM
  yousician_db.public."Rating";


-- select particular song rating records from the Rating table.
SELECT
  "rate"
FROM
  yousician_db.public."Rating"
WHERE
  "id" = 34;

-- select particular song average rating,
-- minimum rating and maximum rating from the Rating table.
SELECT
  AVG("rate")::numeric(10,2) AS "avgRate",
  MIN("rate")                AS "minRate",
  MAX("rate")                AS "maxRate"
FROM
  yousician_db.public."Rating"
WHERE
  "id" = 34;
