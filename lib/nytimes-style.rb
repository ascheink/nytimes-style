require 'date'
require 'yaml'

# A small set of helper methods for generating text that conforms to _The New York Times Manual of Style and Usage_,
# written by [Andrei Scheinkman](https://andreischeinkman.com) and hosted on [Github](https://github.com/ascheink/nytimes-style).
module Nytimes
  module Style
    
    # > "In general, spell out the first nine cardinal and 
    # > ordinal numbers [but] spell any number that begins a sentence..."
    # There are many exceptions to this rule including "ages of people 
    # and animals," "sums of money," "degrees of temperature" and "mentions of the Twelve 
    # Apostles and the Ten Commandments."
    def nytimes_number(n)
      if n < 10
        %w(one two three four five six seven eight nine ten)[n - 1]
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
      str << "#{nytimes_month_and_day date}, #{date.year}"
    end
    
    def nytimes_month_and_day(date)
      "#{nytimes_month date.month} #{date.day}"
    end
    
    def nytimes_month(month)
      raise ArgumentError.new "Unknown month: #{month}" unless (1..12).include? month
      %w(Jan. Feb. March April May June July Aug. Sept. Oct. Nov. Dec.)[month - 1]
    end

    # > "The abbreviation to be used for each state, after the names of cities,
    # > towns and counties&hellip; Use no
    # > spaces between initials like N.H. Do not abbreviate Alaska, Hawaii, Idaho,
    # > Iowa, Ohio and Utah. (Do not ordinarily use the Postal Service’s
    # > two-letter abbreviations; some are hard to tell apart on quick reading.)"
    def nytimes_state_abbrev(postal_code_or_state_name)
      state = states[postal_code_or_state_name]
      raise ArgumentError.new "Unknown postal code or state name: #{postal_code_or_state_name}" unless state
      state['nytimes_abbrev']
    end
    
    private
    
    def states
      unless @states
        @states = {}
        YAML::load(File.open(File.join(File.dirname(__FILE__), 'nytimes-style/states.yml'))).each do |state|
          @states[state['postal_code']] = @states[state['name']] = state
        end
      end
      return @states
    end

  end
end
