-- select username and password from the Login table.
SELECT
  "username",
  "password"
FROM
  webapp_db.public."Login";

-- select password of a particular user from the Login table.
SELECT
  "password"
FROM
  webapp_db.public."Login"
WHERE
  username = 'balaji';
