# Exponential Retry

[![Gem Version](https://img.shields.io/gem/v/exp_retry.svg)](https://rubygems.org/gems/exp_retry)
[![Build Status](https://travis-ci.org/jfiander/exp-retry.svg)](https://travis-ci.org/jfiander/exp-retry)
[![Maintainability](https://api.codeclimate.com/v1/badges/4c8be06f11872994f2c7/maintainability)](https://codeclimate.com/github/jfiander/exp-retry/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/4c8be06f11872994f2c7/test_coverage)](https://codeclimate.com/github/jfiander/exp-retry/test_coverage)

A simple exponential backoff retry wrapper.

## Installation

Add this to your Gemfile:

```ruby
gem 'exp_retry'
```

Or manually install the gem:

```sh
gem install exp_retry
```

## Usage

You can wrap a simple block to enable retries:

```ruby
ExpRetry.new.call do
  something_unreliable
end
```

You can specify which exception class(es) to allow retries for:

```ruby
ExpRetry.new(exception: SpecificError).call do
  something_generic # errors will surface immediately
  something_specific # errors will trigger retries
end

ExpRetry.new(exception: [SpecificError, AnotherError]).call do
  something_generic # errors will surface immediately
  something_specific # errors will trigger retries
end
```

You can specify how many retries to allow:

```ruby
ExpRetry.new(retries: 5).call do
  something_unreliable # will retry 5 times
end
```
