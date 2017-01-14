module AnimeData
  def self.avg_rating_of_shows_in_genre_by_format
    ActiveRecord::Base.connection.execute("
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
    ")
  end
end