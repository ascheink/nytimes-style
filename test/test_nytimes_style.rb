require './lib/nytimes-style'

class NytimesStyleTest < Test::Unit::TestCase
  include Nytimes::Style

  def test_dates
    date = Date.civil(2001, 9, 11)
    assert_equal "Sept. 11", nytimes_month_and_day(date)
    assert_equal "Sept. 11, 2001", nytimes_date(date)
    assert_raise(ArgumentError) { nytimes_month(0) }
  end
  
  def test_date_options
    date = Date.civil(2001, 9, 11)
    assert_equal "Tuesday, Sept. 11, 2001", nytimes_date(date, :day_of_week => true)
    assert_equal "Sept. 11, 2001", nytimes_date(date, :hide_current_year => true)
    this_year = Date.today.year
    recent_date = Date.civil(this_year, 2, 12)
    assert_equal "Feb. 12", nytimes_date(recent_date, :hide_current_year => true)
  end
  
  def test_state_abbrevs
    assert_equal 'Ariz.', nytimes_state_abbrev('AZ')
    assert_equal 'N.H.',  nytimes_state_abbrev('New Hampshire')
    assert_equal 'Wis.',  nytimes_state_abbrev(55)
    assert_raise(ArgumentError) { nytimes_state_abbrev('Canada') }
  end
  
  def test_state_names
    assert_equal 'Arizona', nytimes_state_name('AZ')
    assert_equal 'New Hampshire',  nytimes_state_name('New Hampshire')
    assert_equal 'Wisconsin',  nytimes_state_name(55)
    assert_raise(ArgumentError) { nytimes_state_name(242) }
  end
  
  def test_numbers
    assert_equal 'five', nytimes_number(5)
    assert_equal '12', nytimes_number(12)
  end
  
end