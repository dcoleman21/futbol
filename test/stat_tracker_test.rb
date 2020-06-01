require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require './lib/games'
require './lib/teams'
require './lib/game_teams'
require './lib/stat_tracker'
require 'pry'

class StatTrackerTest < MiniTest::Test
  def setup
    @stat_tracker = StatTracker.from_csv({games:      './data/games.csv',
                                          teams:      './data/teams.csv',
                                          game_teams: './data/game_teams.csv'})
  end

  def test_it_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_it_generates_collections
    assert_equal 7441, @stat_tracker.games.count
    assert_equal 14882, @stat_tracker.game_teams.count
    assert_equal 32, @stat_tracker.teams.count
  end

  def test_it_can_access_data
    assert_equal "6", @stat_tracker.games[4].home_team_id
    assert_equal "Chicago Fire", @stat_tracker.teams[1].team_name
    assert_equal "John Tortorella", @stat_tracker.game_teams[5].head_coach
  end

  #Game Stats Tests
  def test_it_can_get_highest_total_score
    assert_equal 11, @stat_tracker.highest_total_score
  end
  def test_it_can_get_lowest_total_score
    assert_equal 0, @stat_tracker.lowest_total_score
  end
  def test_it_has_percentage_of_home_wins
    assert_equal 0.44, @stat_tracker.percentage_home_wins
  end
  def test_percentage_visitor_wins
    assert_equal 0.36, @stat_tracker.percentage_visitor_wins
  end
  def test_percentage_ties
    assert_equal 0.2, @stat_tracker.percentage_ties
  end
  def test_count_of_games_by_season
    expected = {
      "20122013"=>806,
      "20162017"=>1317,
      "20142015"=>1319,
      "20152016"=>1321,
      "20132014"=>1323,
      "20172018"=>1355
    }
    assert_equal expected, @stat_tracker.count_of_games_by_season
    #assert_includes "20122013" , @stat_tracker.count_of_games_by_season.key?[0]
  end
  def test_average_goals_per_game
    assert_equal 4.22, @stat_tracker.average_goals_per_game
  end
  def test_average_goals_by_season
    expected = {
      "20122013"=>4.12,
      "20162017"=>4.23,
      "20142015"=>4.14,
      "20152016"=>4.16,
      "20132014"=>4.19,
      "20172018"=>4.44
    }
    assert_equal expected, @stat_tracker.average_goals_by_season
  end
  # League Statistics Tests
  def test_it_can_count_teams
    assert_equal 32, @stat_tracker.count_of_teams
  end

  def test_best_offense
    assert_equal "Reign FC", @stat_tracker.best_offense
  end

  def test_worst_offense
    assert_equal "Utah Royals FC", @stat_tracker.worst_offense
  end

  def test_highest_scoring_visitor
    assert_equal "FC Dallas", @stat_tracker.highest_scoring_visitor
  end

  def test_highest_scoring_home_team
    assert_equal "Reign FC", @stat_tracker.highest_scoring_home_team
  end

  def test_lowest_scoring_visitor
    assert_equal "San Jose Earthquakes", @stat_tracker.lowest_scoring_visitor
  end

  def test_lowest_scoring_home_team
    assert_equal "Utah Royals FC", @stat_tracker.lowest_scoring_home_team
  end

  # Season Stats
  def test_it_has_winningest_coach
    assert_equal "Claude Julien", @stat_tracker.winningest_coach("20122013")
  end

  def test_it_has_the_worst_coach
    assert_equal "Martin Raymond", @stat_tracker.worst_coach("20122013")
  end

  def test_it_has_most_accurate_team
    assert_equal "DC United", @stat_tracker.most_accurate_team("20122013")
  end

  def test_it_has_least_accurate_team
    assert_equal "New York City FC", @stat_tracker.least_accurate_team("20122013")
  end

  def test_most_tackles
    assert_equal "FC Cincinnati", @stat_tracker.most_tackles("20122013")
  end

  def test_it_has_fewest_tackles
    assert_equal "Atlanta United", @stat_tracker.fewest_tackles("20122013")
  end

# Team Stats
  def test_it_displays_team_info
      expected = {'team_id' => '4',
                  'franchise_id' => '16',
                  'team_name' => 'Chicago Fire',
                  'abbreviation' => 'CHI',
                  'link' => '/api/v1/teams/4'}
      assert_equal expected, @stat_tracker.team_info('4')
  end

  def test_it_has_best_season
    assert_equal "20132014", @stat_tracker.best_season("6")
  end

  def test_it_has_worst_season
    assert_equal "20132014", @stat_tracker.best_season("6")
  end

  def test_average_win_percentage
    assert_equal 0.49, @stat_tracker.average_win_percentage("6")
    assert_equal 0.43, @stat_tracker.average_win_percentage("3")
    assert_equal 0.44, @stat_tracker.average_win_percentage("16")
  end

  def test_most_goals_scored
    assert_equal 6, @stat_tracker.most_goals_scored("6")
  end

  def test_fewest_goals_scored
    assert_equal 0, @stat_tracker.fewest_goals_scored("16")
  end

  def test_it_has_favorite_opponent
    assert_equal "Montreal Impact", @stat_tracker.favorite_opponent("3")
  end

  def test_it_has_a_rival
    assert_equal "Real Salt Lake", @stat_tracker.rival("6")
  end
end
