# Integrating Coverband Production Coverage Analysis

The method described here makes it as easy as possible to add Coverband coverage tracking. A few simple changes and additions, and the whole mechanism can be enabled and disabled by commenting out one line in the Gemfile and then pushing code to the instance.

## Files Changed

#### Gemfile

Add the following

```ruby
group :production, :staging, :development do
  gem 'coverband'
end
```
