# All of the student names are stored in an array
#  students = [
#    {name: "Dr. Hannibal Lecter", cohort: :november, birthplace: "Lithuania"},
#    {name: "Darth Vader", cohort: :november, birthplace: "Tatooine"},
#    {name: "Nurse Ratched", cohort: :november, birthplace: "Oregon"},
#    {name: "Michael Corleone", cohort: :november, birthplace: "New York"},
#    {name: "Alex DeLarge", cohort: :november, birthplace: "Britain"},
#    {name: "The Wicked Witch of the West", cohort: :november, birthplace: "Oz"},
#    {name: "Terminator", cohort: :november, birthplace: "Los Angeles 2029"},
#    {name: "Freddy Krueger", cohort: :november, birthplace: "Elm Street"},
#    {name: "The Joker", cohort: :november, birthplace: "Gotham"},
#    {name: "Joffrey Baratheon", cohort: :november, birthplace: "King's Landing"},
#    {name: "Norman Bates", cohort: :november, birthplace: "Bates Motel"},
#  ]

# Prompts the user for names of students and stores them in an array
def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # create an empty array
  students = []
  # get the first name
  name = gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    # add the student hash to the array
    students << {name: name, cohort: :november}
    puts "Now we have #{students.count} #{students.count == 1 ? "student" : "students"}"
    # get another name from the user
    name = gets.chomp
  end
  # return the array of students
  students
end

# Prints a header
def print_header
  header = "The students of Villains Academy"
  puts header
  puts "-" * header.length
end

# Takes an array as an input and 'puts' each value within
# def print(students, starting_with)
def print(students)
  puts "No students are currently enrolled" if students.count == 0
  longest_name = students.map { |student| student[:name] }.max_by(&:length)
  longest_birthplace = students.map { |student| student[:birthplace] }.max_by(&:length)
  students.each_with_index do |student, idx|
    # if student[:name].length < 12
    # if student[:name][0].downcase == starting_with.downcase
      # puts "#{idx + 1}. #{student[:name]} from #{student[:birthplace]} (#{student[:cohort].capitalize} cohort)"
      puts "#{(idx + 1).to_s.ljust(2)} | #{student[:name].center(longest_name.length)} | #{student[:birthplace].center(longest_birthplace.length)} | #{student[:cohort].capitalize}"
    # end
  end
end

# Puts a footer line containing a count of the passed in argument
def print_footer(students)
  return if students.count == 0
  puts "Overall, we have #{students.count} great #{students.count == 1 ? "student" : "students"}"
end

# Use the methods to output the student list
students = input_students if students == nil
print_header
# print(students, "T")
print(students)
print_footer(students)