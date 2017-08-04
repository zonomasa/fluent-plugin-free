require 'fluent/input'

class Fluent::FreeInput < Fluent::Input
  Fluent::Plugin.register_input('free', self)

  # Define `router` method of v0.12 to support v0.10 or earlier
  unless method_defined?(:router)
    define_method("router") { Fluent::Engine }
  end

  config_param :interval, :time,   :default => nil
  config_param :unit,     :string, :default => 'mega'
  config_param :mode,     :string, :default => nil
  config_param :tag,      :string, :default => 'memory.free'

  attr_accessor :tick   # For test
  attr_accessor :option # For test

  def configure(conf)
    super
    if @interval
      @tick = interval.to_i
    else
      @tick = 10
    end

    @option = case @unit
              when 'byte' then '-b'
              when 'kilo' then '-k'
              when 'mega' then '-m'
              when 'giga' then '-g'
              else
                raise RuntimeError, "@unit must be one of byte/kilo/mega/giga"
              end
  end

  def start
    super
    @thread = Thread.new(&method(:run))
  end

  def shutdown
    @thread.terminate
    @thread.join
    super
  end

  def run
    loop do
      router.emit(@tag, Fluent::Engine.now, get_free_info)
      sleep @tick
    end
  end

  private
  def get_free_info
    ret = `free #{@option}`.split($/)
    ret.shift
    if @mode == 'actual'
      items = ret[1].split(/\s+/)
    else
      items = ret[0].split(/\s+/)
    end
    free_info = {
      'used'    => items[2],
      'free'    => items[3],
    }
    free_info
  end



end
