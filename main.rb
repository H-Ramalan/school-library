require 'json'
require_relative 'app'
require_relative 'enteries'
app = App.new

def main(app)
  app.load_data
  puts 'Welcome to School Library App!'
  loop do
    puts 'Please select an option by entering a number: '
    puts '1 - List all books'
    puts '2 - List all people'
    puts '3 - Create a person'
    puts '4 - Create a book'
    puts '5 - Create a rental'
    puts '6 - List all rentals for a given person id'
    puts '7 - Exit'

    number = gets.chomp.to_i
    break if number == 7

    if number == 6
      puts 'Please enter ID of person'
      person_id = gets.chomp.to_i
      app.list_rentals(person_id)
    else
      enteries(app, number)
    end
  end
end

at_exit do
  app.save_data
end

main(app)
