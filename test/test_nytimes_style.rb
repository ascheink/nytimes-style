require './lib/nytimes-style'

class NytimesStyleTest < Test::Unit::TestCase
  include Nytimes::Style

  def test_dates
    date = Date.civil(2001, 9, 11)
    assert_equal nytimes_month_and_day(date), "Sept. 11"
    assert_equal nytimes_date(date), "Sept. 11, 2001"
    assert_raise(ArgumentError) { nytimes_month(0) }
  end
  
  def test_state_abbrevs
    assert_equal nytimes_state_abbrev('AZ'), 'Ariz.'
    assert_equal nytimes_state_abbrev('New Hampshire'), 'N.H.'
    assert_raise(ArgumentError) { nytimes_state_abbrev('Canada') }
  end
  
end