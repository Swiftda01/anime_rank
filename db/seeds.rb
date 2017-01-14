require 'csv'

shows = CSV.read("anime.csv")

(1...shows.length - 1).each do |i| 
  show = Show.find_or_create_by(
    name: shows[i][1],
    format: shows[i][3],
    episodes: shows[i][4],
    rating: shows[i][5]
  )
  unless show.genres || shows[i][2].nil?
    genres = shows[i][2].split(",").map(&:lstrip)
    genres.each do |genre|
      show.genres << Genre.find_or_create_by(
        name: genre
      )
    end
  end
end