require 'csv'
class StatTracker
  attr_reader :games, :teams, :game_teams
  def self.from_csv(data)
    @games_collection = CSV.read(data[:games], headers: true, header_converters: :symbol).map {|row| Games.new(row)}
    @teams_collection = CSV.read(data[:teams], headers: true, header_converters: :symbol).map {|row| Teams.new(row)}
    @game_teams_collection = CSV.read(data[:game_teams], headers: true, header_converters: :symbol).map {|row| GameTeams.new(row)}
    StatTracker.new(@games_collection, @teams_collection, @game_teams_collection)
  end

  def initialize(games_collection, teams_collection, game_teams_collection)
    @games      = games_collection
    @teams      = teams_collection
    @game_teams = game_teams_collection
  end
end
