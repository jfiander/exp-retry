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
    @fail_once = 1
    r = ExpRetry.new.call do
      if @fail_once.positive?
        @fail_once -= 1
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
end
