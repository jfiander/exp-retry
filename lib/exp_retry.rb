# frozen_string_literal: true

# Exponential backoff retry wrapper
class ExpRetry
  def self.for(retries: 3, exception: StandardError, verbose: false)
    new(retries: retries, exception: exception, verbose: verbose).call { yield }
  end

  def initialize(retries: 3, exception: StandardError, verbose: false)
    @retries = retries
    @exception = exception
    @verbose = verbose
  end

  def call
    yield if block_given?
  rescue *@exception => e
    check(e)
    retry
  end

  private

  def check(exception)
    retried > @retries ? raise(exception) : delay(exception)
  end

  def retried
    @retried ||= 0
    @retried += 1
  end

  def delay(exception)
    output = "*** #{exception}. Retrying in #{2**@retried} seconds..."
    @verbose ? puts(output) : print('-')
    sleep 2**@retried
  end
end
