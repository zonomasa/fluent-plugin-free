fluent-plugin-free
==================

[![Build Status](http://img.shields.io/travis/zonomasa/fluent-plugin-free.svg?style=flat)][travis]


Input plugin for fluentd to collect memory usage from 'free' command.

'free' command shows system memory usage. This plugin collect values from the command , and input is into fluentd.

[travis]: http://travis-ci.org/zonomasa/fluent-plugin-free

Installation
------------

Add this line to your application's Gemfile:

    gem 'fluent-plugin-free'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fluent-plugin-free


Sample Configration
-------------------

To get memory usage in MegaByte :

    <source>
      type free
      unit mega     # size unit, 'byte', 'kilo', 'mega', 'giga'
      mode actual   # 'actual' mode incldue 'buffers' and 'cache' in 'free' size.
      interval 5    # seconds, you can also use 10s, 20m, 10h
      tag memory.free
    </source>

And you will get like this :

    2014-06-28T10:46:04+09:00   memory.free {"used":"1553","free":"441"}
    2014-06-28T10:46:09+09:00   memory.free {"used":"1553","free":"441"}



Parameters
----------

 * unit

    The unit of memory usage value. You can choose one of 'byte', 'kilo', 'mega' or 'giga'. Default is 'mega'

 * mode

    If you specify 'actual' in the option,the value you get includes 'buffers' and 'cached'.The value in 'mode actual' shows the memory size you can really use.Default is nil.

 * interval

    The interval time to collect value. Numerical number means seconds, and you can also use 's':seconds, 'm':minutes or 'h':hours. Default is 10 (seconds).

 * tag

    The input tag. Default is 'memory.free'


Contributing
------------

1. Fork it ( https://github.com/zonomasa/fluent-plugin-free/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request


Copyright
---------
Author::    TATEZONO Masaki
Copyright:: Copyright (c) 2014 TATEZONO Masaki
License::   Apache License, Version 2.0
