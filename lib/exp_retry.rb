# frozen_string_literal: true

# Exponential backoff retry wrapper
class ExpRetry
  def initialize(retries: 3)
    @retries = retries
  end

  def call
    yield if block_given?
  rescue StandardError => e
    check(e)
    retry
  end

  private

  def check(e)
    retried > @retries ? raise(e) : delay(e)
  end

  def retried
    @retried ||= 0
    @retried += 1
  end

  def delay(e)
    puts "*** #{e}. Retrying in #{2**@retried} seconds..."
    sleep 2**@retried
  end
end
