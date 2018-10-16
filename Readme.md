# Exponential Retry

A simple exponential backoff retry wrapper.

## Usage

```ruby
ExpRetry.new.call do
  something_unreliable
end  
```
