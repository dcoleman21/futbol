require 'csv'
require_relative 'game'
require_relative 'team'
require_relative 'game_team'

class Stats
  attr_reader :games, :teams, :game_teams
  def initialize(data)
    @games      = CSV.read(data[:games], headers: true, header_converters: :symbol).map {|row| Game.new(row)}
    @teams      = CSV.read(data[:teams], headers: true, header_converters: :symbol).map {|row| Team.new(row)}
    @game_teams = CSV.read(data[:game_teams], headers: true, header_converters: :symbol).map {|row| GameTeam.new(row)}
  end
end
