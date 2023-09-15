require 'rspec'
require_relative '../rental'
require_relative '../book'
require_relative '../person'

describe Rental do
  let(:person) { Person.new(21, 'Moe', parent_permission: false) }
  let(:rental) { Rental.new(date, book, person) }
  let(:book) { Book.new('Title',' Author') }
  let(:date) { '2021-09-11' }

  before do
    rental
  end

  it 'initializes with date, book, person' do 
    rental = Rental.new(date, book, person)
    expect(rental.date).to eq(date)
    expect(rental.person).to eq(person)
    expect(rental.book).to eq(book)
  end
  it 'can add rental to rentals' do 
    rental = Rental.new(date, book,  person)
    expect(book.rentals).to include(rental)
  end
end
