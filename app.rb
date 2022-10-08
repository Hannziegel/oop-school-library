require_relative 'student'
require_relative 'teacher'
require_relative 'book'
require_relative 'rental'

class App
  def initialize
    @books = []
    @persons = []
    @rentals = []
  end

  def app_options
    puts '___________________________________________'
    puts '1 - List all books'
    puts '2 - List all people'
    puts '3 - Create a person'
    puts '4 - Create a book'
    puts '5 - Create a rental'
    puts '6 - List all rentals for a given person id'
    puts '7 - Exit'
    puts '___________________________________________'
  end

  def run
    user_answer = 0
    while user_answer != 7
      app_options
      user_answer = gets.to_i
      selected_options(user_answer)
    end
  end

  def selected_options(user_answer) # rubocop:disable Metrics/CyclomaticComplexity
    case user_answer
    when 1
      list_all_books
    when 2
      list_all_people
    when 3
      create_person
    when 4
      create_book
    when 5
      create_rental
    when 6
      list_all_rentals_person_id
    when 7
      p 'Goodbye!'
    end
  end

  def list_all_books
    @books.each do |book|
      puts "Title: #{book.title}, Author: #{book.author}"
    end
  end

  def list_all_people
    @persons.each do |person|
      puts "#{person.class} Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
  end

  def create_person # rubocop:disable Metrics/MethodLength
    print 'Do you want to create a student (1) or a teacher (2)?[Input the number]: '
    student_teacher = gets.to_i

    print 'Age: '
    age = gets.chomp
    print 'Name: '
    name = gets.chomp

    case student_teacher
    when 1
      print 'Has parent permission? [Y/N]: '
      parent_permission = gets.chomp
      parent_permission = parent_permission.downcase == 'y'
      new_student = Student.new(name: name, age: age, parent_permission: parent_permission)
      @persons.push(new_student)
      puts 'Person created successfully'
    when 2
      print 'specialization: '
      specialization = gets.chomp
      new_teacher = Teacher.new(name: name, specialization: specialization, age: age)
      @persons.push(new_teacher)
      puts 'Person created successfully'
    else
      puts 'This option dont exist, try it again'
    end
  end

  def create_book
    print 'Title: '
    title = gets.chomp
    print 'Author: '
    author = gets.chomp
    new_book = Book.new(title: title, author: author)
    @books.push(new_book)
    puts 'Book created successfully'
  end

  def create_rental
    if @books.empty?
      puts 'We dont have any books yet'
    elsif @persons.empty?
      puts 'We dont have any users yet'
    else
      # books
      puts 'Select a book from the following list by number'
      @books.each_with_index { |book, index| puts "#{index} Title: #{book.title}, Author #{book.author}" }
      book_rented = gets.to_i
      # person
      puts 'Select a person from the following list by number (not id)'
      @persons.each_with_index do |person, index|
        puts "#{index} #{person.class} Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
      end
      person_that_rented = gets.to_i
      # date
      print 'Date: '
      date = gets.chomp
      @rentals.push(Rental.new(date, @persons[person_that_rented], @books[book_rented]))
      puts 'Rental created successfully'
    end
  end

  def list_all_rentals_person_id
    print 'ID of person: '
    person_id = gets.to_i
    puts 'Rentals: '
    @rentals.each do |rental|
      puts "Date: #{rental.date}, Book: #{rental.book.title} by #{rental.book.author}" if rental.person.id == person_id
    end
  end
end
