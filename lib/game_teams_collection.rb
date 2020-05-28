require 'csv'

class GameTeamsCollection
  attr_reader :game_teams, :collection

  def initialize(path)
    @game_teams = CSV.read(path, headers: true, header_converters: :symbol)
    @collection = @game_teams.map {|row| GameTeams.new(row)}
  end
end
