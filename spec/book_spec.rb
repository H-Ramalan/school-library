require 'rspec'
require_relative '../book'

describe Book do
  let(:book) { Book.new('New Book', 'Ray') }

  describe '#initialize' do
    it 'Book object is initialize with title and author' do
      expect(book.title).to eq('New Book')
      expect(book.author).to eq('Ray')
    end

    it 'initializes Book object with empty rentals array' do
      expect(book.rentals).to be_empty
    end
  end

  describe '#add_rental' do
    it 'adds a rental to book rentals array' do
      rental = 'Rental data'
      book.add_rental(rental)
      expect(book.rentals).to include(rental)
    end
  end
end
