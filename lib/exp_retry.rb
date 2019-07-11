# frozen_string_literal: true

# Exponential backoff retry wrapper
class ExpRetry
  attr_accessor :retries
  attr_reader :exception, :tried

  def self.for(retries: 3, exception: StandardError, verbose: false)
    new(retries: retries, exception: exception, verbose: verbose).call { yield }
  end

  def initialize(retries: 3, exception: StandardError, wait: 1000, verbose: false)
    @retries = retries
    @tried = 0
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
    raise(exception) if tried >= retries

    increment
    delay
  end

  def increment
    @tried += 1
  end

  def delay
    output = "*** #{@exception}. Retrying in #{time} seconds..."
    @verbose ? puts(output) : print('-')
    sleep time
  end

  def time
    2**tried * (@wait.to_f / 1000)
  end
end
