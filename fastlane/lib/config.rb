##
# This class used just here, inside current file
#
class BaseClass
  def self.all_variables
    constants.map &self.method(:const_get)
  end
end

class Options < BaseClass
  # Variables: true, false
  WATCH = :watch
  # Variables: true, false
  CLEAN = :clean
  # Variables: true, false
  COVERAGE = :coverage
end