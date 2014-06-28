require 'helper'

class FreeInputTest < Test::Unit::TestCase
  def setup
    Fluent::Test.setup
  end

  CONFIG = %[
    interval 10
  ]


  def create_driver(conf = CONFIG)
    Fluent::Test::InputTestDriver.new(Fluent::FreeInput).configure(conf)
  end


  def test_configure
    d = create_driver
    


  end

end
