# Integrating Coverband Production Coverage Analysis

The method described here makes it as easy as possible to add Coverband coverage tracking. A few simple changes and additions, and the whole mechanism can be enabled and disabled by commenting out one line in the Gemfile and then pushing code to the instance.

## Files Changed

### Gemfile

Add the following

```ruby
group :production, :staging, :development do
  gem 'coverband'
end
```

### config/routes.rb

Add the following near the end of the file.

```ruby
  if defined?(Coverband::Reporters) == 'constant'
    authenticate :user, lambda { |u| u.admin_access? } do
      mount Coverband::Reporters::Web.new, at: '/coverage'
    end
  end
 ```
 
Note that this assumes a specific authentication in this example. If you're using ActiveAdmin, for instance, you'll authenticate off of Warden. Something kind of like:

```ruby
if defined?(Coverband::Reporters) == 'constant'
  admin_web_constraint = lambda do |request|
    current_user = request.env['warden'].user
    current_user.present?
  end

  constraints admin_web_constraint do
     mount Coverband::Reporters::Web.new, at: '/coverage'
  end
end
```

### config/initializers/coverband.rb

Copy the `coverband.rb` file from this repository into `config/initializers` and make any changes you feel are needed. Probably the only change would be the Redis URL.

## Using Coverband

**<span style="color: red">VERY IMPORTANT:</span> You MUST have a shared Redis server that all your instances use. This will be what gets filled in to the initializer either by hard-coding or setting an ENV variable. For single-server Staging instances or development, you can get by with a local Redis server. But for Production you will need Redis in the cloud that every instance can access.**

