require 'minitest/autorun'
require 'minitest/pride'
require './lib/games'
require './lib/teams'
require './lib/game_teams'
require './lib/stat_tracker'
require 'pry'

class StatTrackerTest < MiniTest::Test
  def setup
    @stat_tracker = StatTracker.from_csv({games:      './fixture/games_fixture.csv',
                                          teams:      './data/teams.csv',
                                          game_teams: './fixture/game_teams_fixture.csv'})
  end

  def test_it_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_it_generates_collections
    assert_equal 29, @stat_tracker.games.count
    assert_equal 34, @stat_tracker.game_teams.count
    assert_equal 32, @stat_tracker.teams.count
  end

  def test_it_can_access_data
    assert_equal "5", @stat_tracker.games[4].home_team_id
    assert_equal "Chicago Fire", @stat_tracker.teams[1].team_name
    assert_equal "John Tortorella", @stat_tracker.game_teams[5].head_coach
  end
#Game Stats Tests
  def test_it_can_get_highest_total_score
    assert_equal 5, @stat_tracker.highest_total_score
  end

  def test_it_can_get_lowest_total_score
    assert_equal 1, @stat_tracker.lowest_total_score
  end

  def test_it_has_percentage_of_home_games
    assert_equal 0.59, @stat_tracker.percentage_home_wins
  end

  def test_percentage_visitor_wins
    assert_equal 0.29, @stat_tracker.percentage_visitor_wins
  end

  def test_percentage_ties
    assert_equal 0.12, @stat_tracker.percentage_ties
  end

  def test_count_of_games_by_season
    expected = {
      "20122013" => 21,
      "20172018" => 2,
      "20162017" => 2,
      "20152016" => 2,
      "20132014" => 2
    }

    assert_equal expected, @stat_tracker.count_of_games_by_season
    #assert_includes "20122013" , @stat_tracker.count_of_games_by_season.key?[0]
  end

  def test_average_goals_per_game
    assert_equal 3.65, @stat_tracker.average_goals_per_game
  end

  def test_average_goals_by_season
    expected = {
      "20122013"=>3.71,
      "20172018"=>4.0,
      "20162017"=>4.0,
      "20152016"=>4.0,
      "20132014"=>4.0
    }
    assert_equal expected, @stat_tracker.average_goals_by_season
  end

  # League Statistics Tests
  def test_it_can_count_teams
    assert_equal 32, @stat_tracker.count_of_teams
  end

  def test_best_offense
    assert_equal 'FC Dallas', @stat_tracker.best_offense
  end

  def test_worst_offense
    assert_equal 'Sporting Kansas City', @stat_tracker.worst_offense
  end

  # Team Statistics Tests
  def test_it_displays_team_info
    expected = {'team_id' => '4',
                'franchise_id' => '16',
                'team_name' => 'Chicago Fire',
                'abbreviation' => 'CHI',
                'link' => '/api/v1/teams/4'}
    assert_equal expected, @stat_tracker.team_info('4')
  end

  def test_highest_scoring_visitor
    assert_equal "FC Dallas", @stat_tracker.highest_scoring_visitor
  end

  def test_highest_scoring_home_team
    assert_equal "LA Galaxy", @stat_tracker.highest_scoring_home_team
  end

  def test_lowest_scoring_visitor
    assert_equal "Sporting Kansas City", @stat_tracker.lowest_scoring_visitor
  end

  def test_lowest_scoring_home_team
    assert_equal "Sporting Kansas City", @stat_tracker.lowest_scoring_home_team
  end

  #_________________
  def test_most_goals_scored
    assert_equal 4, @stat_tracker.most_goals_scored("6")
  end
end
