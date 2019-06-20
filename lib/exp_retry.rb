# frozen_string_literal: true

# Exponential backoff retry wrapper
class ExpRetry
  attr_accessor :retries
  attr_reader :exception

  def self.for(retries: 3, exception: StandardError, verbose: false)
    new(retries: retries, exception: exception, verbose: verbose).call { yield }
  end

  def initialize(retries: 3, exception: StandardError, wait: 1000, verbose: false)
    @retries = retries
    @exception = exception
    @verbose = verbose
    @wait = wait
  end

  def call
    yield if block_given?
  rescue *@exception => e
    check(e)
    retry
  end

private

  def check(exception)
    raise(exception) unless retries.positive?

    decrement
    delay
  end

  def decrement
    @retries -= 1
  end

  def delay
    output = "*** #{@exception}. Retrying in #{time} seconds..."
    @verbose ? puts(output) : print('-')
    sleep time
  end

  def time
    2**retries * (@wait.to_f / 1000)
  end
end
