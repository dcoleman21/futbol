require 'CSV'

class GamesCollection < Games
  attr_reader :games, :collection
  def initialize(path)
    @games = CSV.read(path, headers: true, header_converters: :symbol)
    @collection = games.map {|row| Games.new(row)}
  end
end
