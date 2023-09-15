require 'rspec'
require_relative '../trimmer_decorator'
require_relative '../person'

describe TrimmerDecorator do
  let(:person) { Person.new(24, 'Rogermillertony') }
  let(:decorated_person) { TrimmerDecorator.new(person) }

  it 'correctly trims a long name' do
    person.name = 'Rogermiller'
    expect(decorated_person.correct_name).to eq('Rogermille')
  end
  it 'does not trims name of 10 characters' do
    person.name = 'Rogermiller'
    expect(decorated_person.correct_name).to eq('Rogermille')
  end
end