require_relative 'person'
require_relative 'student'
require_relative 'teacher'
require_relative 'extra_decorators'
require_relative 'classroom'
require_relative 'book'
require_relative 'rental'

amanda = Person.new(age: 12, name: 'Amanda', parent_permission: false)

rodrigo = Person.new(age: 18)
jose = Student.new(classroom: 101, age: 23)
karla = Teacher.new(specialization: 'Ride Horses', age: 19)
valentino = Teacher.new(specialization: 'Mocking', age: 12)

p amanda.can_use_services?
p rodrigo.age
p jose.classroom
p jose.name
p jose.can_use_services?
p jose.play_hooky
p karla.specialization
p karla.can_use_services?
p valentino.can_use_services?
p valentino.age

person = Person.new(age: 22, name: 'maximilianus')
p person.correct_name
capitalized_person = CapitalizeDecorator.new(person)
p capitalized_person.correct_name
capitalized_trimmed_person = TrimmerDecorator.new(capitalized_person)
p capitalized_trimmed_person.correct_name

ruby = Classroom.new('ruby')
p ruby
p jose.classroom
ruby.add_student(jose)
p ruby
p jose
book = Book.new(title: 'The name of the Wind', author: 'Patrick Rothfuss')
p book
rental = Rental.new('31 of Oct, 1992', jose, book)
p rental
