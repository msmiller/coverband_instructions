# .../config/initializers/coverband.rb

if defined?(Coverband::Reporters) == 'constant'

  Coverband.configure do |config|
    config.store = Coverband::Adapters::RedisStore.new(Redis.new(url: ENV['MY_REDIS_URL']))

    config.logger = Rails.logger
    config.report_on_exit = false

    config.background_reporting_enabled = true
    # Add a wiggle (in seconds) to the background thread to avoid all your servers reporting at the same time:
    config.reporting_wiggle = 30

    # # configure S3 integration
    # config.s3_bucket = 'coverband-demo'
    # config.s3_region = 'us-east-1'
    # config.s3_access_key_id = ENV['AWS_ACCESS_KEY_ID']
    # config.s3_secret_access_key = ENV['AWS_SECRET_ACCESS_KEY']

    # config options false, true. (defaults to false)
    # true and debug can give helpful and interesting code usage information
    # and is safe to use if one is investigating issues in production, but it will slightly
    # hit perf.
    config.verbose = false

    # default false. button at the top of the web interface which clears all data
    config.web_enable_clear = true

    # default false. Experimental support for tracking view layer tracking.
    # Does not track line-level usage, only indicates if an entire file
    # is used or not.
    config.track_views = true

    config.ignore +=  ['config/application.rb',
                       'config/boot.rb',
                       'config/puma.rb',
                       'config/schedule.rb',
                       'config/*',
                       'bin/*',
                       'config/environments/*',
                       'lib/tasks/*']



  end

end # defined?(Coverband::Reporters)
