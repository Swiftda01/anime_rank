SELECT format, count(shows.format) FROM shows GROUP BY format;

format   | count
---------+-------
 Music   |   488
         |     0
 Movie   |  2348
 ONA     |   659
 TV      |  3787
 Special |  1676
 OVA     |  3311

SELECT
    shows.format,
    genres.name AS genre_name,
    count(shows.format) AS show_count
FROM shows
  LEFT OUTER JOIN show_genres ON shows.id = show_genres.show_id
  LEFT OUTER JOIN genres ON show_genres.genre_id = genres.id
GROUP BY shows.format, genres.name
ORDER BY shows.format ASC;

format   |  genre_name   | show_count
---------+---------------+------------
 Movie   | Mecha         |        166
 Movie   | Vampire       |          9
 Movie   | Hentai        |          8
 Movie   | Ecchi         |         32
 Movie   | Shounen Ai    |          5
 Movie   | Supernatural  |        164
 Movie   | Cars          |         12
 ...

SELECT
    shows.format,
    genres.name AS genre_name,
    count(shows.format) AS show_count,
    CAST(AVG(shows.rating) AS NUMERIC(10,2)) AS avg_rating
FROM shows
  LEFT OUTER JOIN show_genres ON shows.id = show_genres.show_id
  LEFT OUTER JOIN genres ON show_genres.genre_id = genres.id
WHERE shows.format IS NOT NULL
GROUP BY shows.format, genres.name
ORDER BY shows.format ASC;

format   |  genre_name   | show_count | avg_rating
---------+---------------+------------+------------
 Movie   | Mecha         |        166 |       6.46
 Movie   | Vampire       |          9 |       7.53
 Movie   | Hentai        |          8 |       5.52
 Movie   | Ecchi         |         32 |       6.99
 Movie   | Shounen Ai    |          5 |       7.64
 Movie   | Supernatural  |        164 |       7.04
 Movie   | Cars          |         12 |       6.56
 ...
