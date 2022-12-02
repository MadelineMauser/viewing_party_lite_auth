class Party < ApplicationRecord
  has_many :party_users
  has_many :users, through: :party_users

  def invited_users
    users.where('party_users.host = ?', false).pluck(:name)
  end
  
  def host
    users.where('party_users.host = ?', true).first.name
  end

  def movie_details
    movie_search = MovieSearch.new
    movie_search.retrieve_movie_by_name(self.movie_title)
  end

  def movie_runtime
    movie_expanded_details.runtime
  end

  def movie_expanded_details
    movie_search = MovieSearch.new
    movie_search.retrieve_movie(movie_details.id)
  end
end
