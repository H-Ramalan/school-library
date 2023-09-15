require 'rspec'
require_relative '../decorator'
require_relative '../capitalize_decorator'

describe CapitalizeDecorator do
  let(:base_decorator) { double('BaseDecorator') }
  let(:capitalize_decorator) { CapitalizeDecorator.new(base_decorator) }

  describe '#correct_name' do
    it 'capitalizes correct name returned by base decorator' do
      allow(base_decorator).to receive(:correct_name).and_return('ray')
      expect(capitalize_decorator.correct_name).to eq('Ray')
    end
  end
end
