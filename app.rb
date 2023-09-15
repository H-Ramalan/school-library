require_relative 'book'
require_relative 'person'
require_relative 'rental'
require_relative 'student'
require_relative 'teacher'
require_relative 'classroom'
require_relative 'store_files'

class App
  def initialize
    @books = []
    @people = []
    @rentals = []
    @rentals_file_path = 'rentals.json'
  end

  def create_person
    print 'Enter (1) to create a student or (2) to create a teacher: '
    type = gets.chomp.to_i
    case type
    when 1
      create_student
    when 2
      create_teacher
    else
      puts 'Please enter a valid input'
    end
  end

  def create_student
    puts 'Age: '
    age = gets.chomp.to_i
    puts 'Name: '
    name = gets.chomp
    puts 'Has parent permission? [Y/N]: '
    parent_permission = gets.chomp
    person = Student.new(age, parent_permission, name: name)
    @people.push(person)
    puts 'Student successfully created'
  end

  def create_teacher
    puts 'Name: '
    name = gets.chomp
    puts 'Age: '
    age = gets.chomp.to_i
    puts 'Specialization: '
    specialization = gets.chomp
    person = Teacher.new(age, specialization, name: name)
    @people.push(person)
    puts 'Teacher successfully created'
  end

  def create_book
    puts 'Title: '
    title = gets.chomp
    puts 'Author: '
    author = gets.chomp
    book = Book.new(title, author)
    @books.push(book)
    puts 'Book successfully created'
  end

  def create_rental
    person_index = select_person
    book_index = select_book
    print 'Date: '
    date = gets.chomp
    @rentals.push(Rental.new(date, @books[book_index], @people[person_index]))
    puts 'Rentel successfully created'
    save_data
  end

  def list_rentals(person_id)
    rentals_files = ReadFile.new('rentals.json').read || []
    person_rentals = rentals_files.select { |rental| rental['person']['id'] == person_id }

    if person_rentals.empty?
      puts 'No available rentals for person with that ID.'
    else
      person_rentals.each do |rental|
        date = rental['date']
        book_title = rental['book']['title']
        book_author = rental['book']['author']
        person_type = rental['person']['type']
        person_id = rental['person']['id']
        person_age = rental['person']['age']
        person_name = rental['person']['name']

        puts "Date: #{date}"
        puts "Book Title: #{book_title}"
        puts "Book Author: #{book_author}"
        puts "Person Type: #{person_type}"
        puts "person ID: #{person_id}"
        puts "Person Age: #{person_age}"
        puts "Person Name: #{person_name}"
      end
    end
  end

  def select_book
    puts 'Select book ffrom the number: '
    list_people
    gets.chomp.to_i
  end

  def select_person
    puts 'Select person from the following number (not id): '
    list_people
    gets.chomp.to_i
  end

  def list_books
    @books.each_with_index do |book, index|
      puts "#{index} - Title: #{book.title}, Author: #{book.author}"
    end
  end

  def list_people
    @people.each_with_index do |person, index|
      type = person.instance_of?(Student) ? 'Student' : 'Teacher'
      puts "#{index} - [#{type}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
  end

  # def list_rentals
  #   if @rentals.empty?
  #     puts 'There are no rentals to show'
  #   else
  #     puts 'ID of person: '
  #     person_id = gets.chomp.to_i
  #     puts 'Rentals: '
  #     @rentals.each do |rental|
  #       if person_id == rental.person.id
  #         puts "Date: #{rental.date}, Book '#{rental.book.title}' by #{rental.book.author}"
  #       end
  def load_data
    load_books
    load_people
  end

  def load_books
    @books = ReadFile.new('books.json').read.map { |book| Book.new(book['title'], book['author']) }
  end

  def load_people
    people_data = ReadFile.new('people.json').read || []
    students = []
    teachers = []

    people_data.each do |person|
      if person['type'] == 'student'
        students.push(load_student(person))
      elsif person['type'] == 'teacher'
        teachers.push(load_teacher(person))
      end
    end
    @people = students + teachers
  end

  def load_student(data)
    age = data['age']
    name = data.key?('name') ? data['name'] : 'Unknown'
    student = Student.new(age, data['parent_permission'], name: name)
    student.id = data['id']
    student
  end

  def load_teacher(data)
    age = data['age']
    specialization = data['specialization']
    name = data.key?('name') ? data['name'] : 'Unknown'
    teacher = Teacher.new(age, specialization, name: name)
    teacher.id = data['id']
    teacher
  end

  def save_data
    save_books
    save_people
    save_rentals
  end

  def save_books
    books_data = @books.map { |book| { title: book.title, author: book.author } }
    WriteFile.new('books.json').write(books_data)
  end

  def save_rentals
    return unless @rentals.any?

    ReadFile.new('rentals.json').read || ([] + @rentals.map do |rental|
      {
        date: rental.date,
        book: { title: rental.book.title, author: rental.book.author },
        person: { type: rental.person.class.to_s, id: rental.person.id, age: rental.person.age,
                  name: rental.person.name }
      }
    end)
    WriteFile.new('rentals.json').write(rentals_data)
  end

  def save_people
    return unless @people.any?

    @people.select { |person| person.is_a?(Teacher) }.map do |teacher|
      { type: 'teacher', id: teacher.id, age: teacher.age, name: teacher.name, specialization: teacher.specialization }
    end

    @people.select { |person| person.is_a?(Student) }.map do |student|
      { type: 'student', age: student.age, id: student.id, name: student.name }
    end
  end
end
