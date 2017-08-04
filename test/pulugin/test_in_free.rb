require 'helper'
require 'fluent/test/driver/input'

class FreeInputTest < Test::Unit::TestCase
  def setup
    Fluent::Test.setup
  end

  DEFAULT_CONFIG = %[
  ]

  CONFIG = %[
    interval 10m
    mode actual
    tag  testtag
    unit kilo
  ]

  CONFIG_BAD = %[
    interval 10m
    mode actual
    tag  testtag
    unit byto
  ]

  CONFIG_EMIT1 = %[
    interval 2
    mode actual
    tag  emit
    unit mega
  ]

  CONFIG_EMIT2 = %[
    interval 2
    tag  emit
    unit kilo
  ]

  def create_driver(conf = DEFAULT_CONFIG)
    Fluent::Test::Driver::Input.new(Fluent::Plugin::FreeInput).configure(conf)
  end

  def test_configure_default
    d = create_driver
    assert_equal 10,             d.instance.tick
    assert_equal nil,            d.instance.mode
    assert_equal "memory.free",  d.instance.tag
    assert_equal "mega",         d.instance.unit
    assert_equal "-m",           d.instance.option
  end

  def test_configure
    d = create_driver(CONFIG)
    assert_equal 600,        d.instance.tick
    assert_equal "actual",   d.instance.mode
    assert_equal "testtag",  d.instance.tag
    assert_equal "kilo",     d.instance.unit
    assert_equal "-k",       d.instance.option
  end

  def test_configure_bad
    assert_raise(RuntimeError) {
      d = create_driver(CONFIG_BAD)
    }
  end

  # mode => actual, unit => mega
  def test_emit1
    d = create_driver(CONFIG_EMIT1)
    d.run(expect_emits: 1)
    com_ret = `free #{d.instance.option}`
    used = com_ret.split($/)[2].split(/\s+/)[2]
    free = com_ret.split($/)[2].split(/\s+/)[3]
    events = d.events.map{|e| e.last}.first
    assert (events["used"].to_i - used.to_i).abs < 30
    assert (events["free"].to_i - free.to_i).abs < 30
  end

  # mode => nil, unit => kilo
  def test_emit2
    d = create_driver(CONFIG_EMIT2)
    d.run(expect_emits: 1)
    com_ret = `free #{d.instance.option}`
    used = com_ret.split($/)[1].split(/\s+/)[2]
    free = com_ret.split($/)[1].split(/\s+/)[3]
    events = d.events.map{|e| e.last}.first
    assert (events["used"].to_i - used.to_i).abs < 30 * 1024
    assert (events["free"].to_i - free.to_i).abs < 30 * 1024
  end

end
