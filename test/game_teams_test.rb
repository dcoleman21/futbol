require 'minitest/autorun'
require 'minitest/pride'
require './lib/game_teams'
require 'pry'

class GameTeamsTest < Minitest::Test
def setup
  @game_teams = GameTeams.new({
    game_id: 2012030221,
    team_id: 3,
    hoa: "away",
    result: "LOSS",
    settled_in: "OT",
    head_coach: "John Tortorella",
    goals: 2,
    shots: 8,
    tackles: 44,
    pim: 8,
    power_play_opportunities: 3,
    power_play_goals: 0,
    face_off_win_percentage: 44.8,
    giveaways: 17,
    takeaways: 7
    })
end

def test_it_exists
  assert_instance_of GameTeams, @game_teams
end




end
