= nytimes-style

Helper methods for generating text that conforms to _The New York Times Manual of Style and Usage_.

Annotated source code: http://ascheink.github.com/nytimes-style

== INSTALLATION

  gem install nytimes-style

== USAGE

  require 'nytimes-style'
  include Nytimes::Style
  
  >> nytimes_date Date.today
  # => "May 12, 2011"

  >> nytimes_state_abbrev 'AZ'
  # => "Ariz."  

== AUTHOR

Andrei Scheinkman, andrei@nytimes.com
