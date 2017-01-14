require './lib/anime_data'
class ShowsController < ApplicationController

  def data
    @results = AnimeData.avg_rating_of_shows_in_genre_by_format
    respond_to do |format|
      format.html {}
      format.json {
        root = {name: "root", children: []}
        formats = ActiveRecord::Base.connection.execute("
          SELECT DISTINCT format FROM shows;")
        formats.each do |show_format|
          format_hash = {name: show_format["format"], children: []}
          @results.each do |result|
            # fill up employee data
            if result["format"] == show_format["format"]
              format_hash[:children] << {name: result["genre_name"], size: result["show_count"].to_f}
            end
          end
          root[:children] << format_hash
        end
        render json: root
      }
    end
  end

  def index
    respond_to do |format|
      format.html {
        show_results = Show.search(params[:name_search])
        if (show_results.count > 0)
          @shows = order_records(show_results)#.paginate(page: params[:page], per_page: 5)
        else
          @shows = Show.limit(10)
        end
        # @genres = Genre.order(:name)
      }
      format.json {
        # render json: Show.search(params[:q]).map{|show| show._source.name}.uniq
        render json: order_records(Show.search(params[:q])).to_json.html_safe
      }
    end
    # genre = Genre.find_by(name: params[:genre_search])
    # @genre_results = genre.shows
  end

  private
  def order_records(search_results)
    search_results.records.order('rating DESC').reject{ |show| show.rating.nil? }
  end
end
