require 'rspec'
require_relative '../nameable'
require_relative '../decorator'

describe Decorator do
  let(:nameable) { double('Nameable') }
  let(:decorator) { Decorator.new(nameable) }

  describe '#initialize' do
    it 'initializes a decorator with a nameable object' do
      expect(decorator.nameable).to eq(nameable)
    end
  end
end
