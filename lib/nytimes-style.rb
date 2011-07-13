require 'date'
require 'yaml'

# A small set of helper methods for generating text that conforms to _The New York Times Manual of Style and Usage_,
# hosted on [Github](https://github.com/ascheink/nytimes-style).
module Nytimes
  module Style
    
    # > "In general, spell out the first nine cardinal and 
    # > ordinal numbers [but] spell any number that begins a sentence..."
    # Exceptions include "ages of people 
    # and animals," "sums of money," "degrees of temperature" and "mentions of the Twelve 
    # Apostles and the Ten Commandments."
    def nytimes_number(n)
      if n < 10
        %w(one two three four five six seven eight nine)[n - 1]
      else
        n.to_s
      end
    end

    # > "Abbreviate the names of months from August through
    # > February in news copy when they are followed by numerals: Aug. 1; Sept.
    # > 2; Oct. 3; Nov. 4; Dec. 5; Jan. 6; Feb. 7. Do not abbreviate March,
    # > April, May, June and July except as a last resort in a chart or table."
    def nytimes_date(date, opts={})
      str = ""
      str << date.strftime('%A, ') if opts[:day_of_week]
      str << nytimes_month_and_day(date)
      str << ", #{date.year}" unless opts[:hide_current_year] && date.year == Date.today.year
      return str
    end
    
    def nytimes_month_and_day(date)
      "#{nytimes_month date.month} #{date.day}"
    end
    
    def nytimes_month(month)
      raise ArgumentError.new "Unknown month: #{month}" unless (1..12).include? month
      %w(Jan. Feb. March April May June July Aug. Sept. Oct. Nov. Dec.)[month - 1]
    end
    
    # > "Use numerals in giving clock time: 10:30 a.m.; 10:30.
    # > Do not use half-past 10 except in a direct quotation.
    # > Also avoid the redundant 10:30 a.m. yesterday morning and Monday afternoon at 2 p.m."
    def nytimes_time(time, opts={})
      raise ArgumentError.new "Time or DateTime required" unless time.class == DateTime || time.class == Time
      str = ""
      str << time.strftime("%l:%M").strip
      str << time.strftime(" %p").sub('PM','p.m.').sub('AM','a.m.') unless opts[:hide_abbreviation]
      str
    end

    # > "The abbreviation to be used for each state, after the names of cities,
    # > towns and counties&hellip; Use no
    # > spaces between initials like N.H. Do not abbreviate Alaska, Hawaii, Idaho,
    # > Iowa, Ohio and Utah. (Do not ordinarily use the Postal Service’s
    # > two-letter abbreviations; some are hard to tell apart on quick reading.)"
    def nytimes_state_abbrev(state_name_or_code)
      state = states[state_name_or_code]
      raise ArgumentError.new "Unknown postal code, state name or FIPS code: #{state_name_or_code}" unless state
      state['nytimes_abbrev']
    end
    
    def nytimes_state_name(state_abbrev_or_code)
      state = states[state_abbrev_or_code]
      raise ArgumentError.new "Unknown postal code, abbreviation or FIPS code: #{state_abbrev_or_code}" unless state
      state['name']
    end
    
    private

    STATE_DATA_FILE = File.join(File.dirname(__FILE__), 'nytimes-style/states.yml')

    def states
      @states ||= YAML::load(File.open(STATE_DATA_FILE)).inject({}) do |h, state|
        h.merge({ state['postal_code'] => state, state['name'] => state, state['fips_code'] => state })
      end
    end
    

  end
end
