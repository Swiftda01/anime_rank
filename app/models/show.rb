require 'elasticsearch/model'

class Show < ApplicationRecord
  has_many :show_genres
  has_many :genres, through: :show_genres

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  settings index: { number_of_shards: 1 } do
    mappings dynamic: 'false' do
      indexes :shows, analyzer: 'english', index_options: 'offsets'
    end
  end
end
