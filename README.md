SpreeUserSalePrice
==================

Extension for Spree that adds possibility to define product sales for specified users.

Installation
------------

Add spree_user_sale_price to your Gemfile:

```ruby
gem 'spree_user_sale_price'
```

Bundle your dependencies and run the installation generator:

```shell
bundle
bundle exec rails g spree_user_sale_price:install
```

Testing
-------

First bundle your dependencies, then run `rake`. `rake` will default to building the dummy app if it does not exist, then it will run specs. The dummy app can be regenerated by using `rake test_app`.

```shell
bundle
bundle exec rake
```

When testing your applications integration with this extension you may use it's factories.
Simply add this require statement to your spec_helper:

```ruby
require 'spree_user_sale_price/factories'
```

Copyright (c) 2015 [Vlado Rosancic], released under the New BSD License