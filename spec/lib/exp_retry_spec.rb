# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ExpRetry do
  it 'should allow normal execution' do
    r = ExpRetry.new.call do
      'Something'
    end

    expect(r).to eql('Something')
  end

  it 'should allow normal execution' do
    @fail_once = true
    r = ExpRetry.new.call do
      if @fail_once
        @fail_once = false
        raise 'Fail once'
      end
      'Something'
    end

    expect(r).to eql('Something')
  end

  it 'should raise after too many retries' do
    expect do
      ExpRetry.new.call { raise 'Fail forever' }
    end.to raise_error(RuntimeError, 'Fail forever')
  end

  it 'should raise after too many retries with a specified exception class' do
    expect do
      ExpRetry.new(exception: RuntimeError).call { raise 'Fail forever again' }
    end.to raise_error(RuntimeError, 'Fail forever again')
  end

  it 'should not retry for a non-matching exception class' do
    expect do
      ExpRetry.new(exception: RuntimeError).call { raise ArgumentError }
    end.to raise_error(ArgumentError)
  end
end
