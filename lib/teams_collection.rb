require 'CSV'
require_relative './teams'

class TeamsCollection
  attr_reader :teams

  def initialize(data)
    @teams = data
  end
end
