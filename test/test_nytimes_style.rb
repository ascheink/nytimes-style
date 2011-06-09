require './lib/nytimes-style'

class NytimesStyleTest < Test::Unit::TestCase
  include Nytimes::Style

  def test_dates
    date = Date.civil(2001, 9, 11)
    assert_equal nytimes_month_and_day(date), "Sept. 11"
    assert_equal nytimes_date(date), "Sept. 11, 2001"
    assert_raise(ArgumentError) { nytimes_month(0) }
  end
  
  def test_date_options
    date = Date.civil(2001, 9, 11)
    assert_equal nytimes_date(date, :day_of_week => true), "Tuesday, Sept. 11, 2001"
    assert_equal nytimes_date(date, :hide_current_year => true), "Sept. 11, 2001"
    this_year = Date.today.year
    recent_date = Date.civil(this_year, 2, 12)
    assert_equal nytimes_date(recent_date, :hide_current_year => true), "Feb. 12"
  end
  
  def test_state_abbrevs
    assert_equal nytimes_state_abbrev('AZ'), 'Ariz.'
    assert_equal nytimes_state_abbrev('New Hampshire'), 'N.H.'
    assert_raise(ArgumentError) { nytimes_state_abbrev('Canada') }
  end
  
  def test_numbers
    assert_equal nytimes_number(5), 'five'
    assert_equal nytimes_number(12), '12'
  end
  
end