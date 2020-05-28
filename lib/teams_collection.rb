require 'csv'

class TeamsCollection
  attr_reader :teams, :collection

  def initialize(path)
    @teams = CSV.read(path, headers: true, header_converters: :symbol)
    @collection = @teams.map {|row| Teams.new(row)}
  end
end
