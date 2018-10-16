# Exponential Retry

[![Build Status](https://travis-ci.org/jfiander/exp-retry.svg)](https://travis-ci.org/jfiander/exp-retry)
[![Maintainability](https://api.codeclimate.com/v1/badges/4c8be06f11872994f2c7/maintainability)](https://codeclimate.com/github/jfiander/exp-retry/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/4c8be06f11872994f2c7/test_coverage)](https://codeclimate.com/github/jfiander/exp-retry/test_coverage)

A simple exponential backoff retry wrapper.

## Usage

```ruby
ExpRetry.new.call do
  something_unreliable
end
```
