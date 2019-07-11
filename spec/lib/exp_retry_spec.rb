# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ExpRetry do
  let(:wait) { 50 }

  it 'allows normal execution' do
    r = described_class.new.call { 'Something' }

    expect(r).to eql('Something')
  end

  it 'allows normal execution using for' do
    r = described_class.for { 'Something' }

    expect(r).to eql('Something')
  end

  it 'allows normal execution with a single failure' do
    fail_once = true
    r = described_class.new(wait: wait).call do
      if fail_once
        fail_once = false
        raise 'Fail once'
      end
      'Something'
    end

    expect(r).to eql('Something')
  end

  it 'allows normal execution with multiple exceptions' do
    fail_once = true
    r = described_class.new(exception: [RuntimeError, ArgumentError], wait: wait).call do
      if fail_once
        fail_once = false
        raise 'Fail once again'
      end
      'Something'
    end

    expect(r).to eql('Something')
  end

  it 'raises after too many retries' do
    expect do
      described_class.new(wait: wait).call { raise 'Fail forever' }
    end.to raise_error(RuntimeError, 'Fail forever')
  end

  it 'raises after too many retries with a specified exception class' do
    expect do
      described_class.new(exception: RuntimeError, wait: wait).call { raise 'Fail forever again' }
    end.to raise_error(RuntimeError, 'Fail forever again')
  end

  it 'does not retry for a non-matching exception class' do
    expect do
      described_class.new(exception: RuntimeError, wait: wait).call { raise ArgumentError }
    end.to raise_error(ArgumentError)
  end
end
