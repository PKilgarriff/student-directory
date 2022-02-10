# All of the student names are stored in an array
 students = [
   {name: "Dr. Hannibal Lecter", cohort: :november},
   {name: "Darth Vader", cohort: :november},
   {name: "Nurse Ratched", cohort: :november},
   {name: "Michael Corleone", cohort: :november},
   {name: "Alex DeLarge", cohort: :november},
   {name: "The Wicked Witch of the West", cohort: :november},
   {name: "Terminator", cohort: :november},
   {name: "Freddy Krueger", cohort: :november},
   {name: "The Joker", cohort: :november},
   {name: "Joffrey Baratheon", cohort: :november},
   {name: "Norman Bates", cohort: :november},
 ]

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
  puts "The students of Villains Academy"
  puts "-------------"
end

# Takes an array as an input and 'puts' each value within
def print(students)
  students.each_with_index do |student, idx|
    # if student[:name].length < 12
      puts "#{idx + 1}. #{student[:name]} (#{student[:cohort].capitalize} cohort)"
    # end
  end
end

# Puts a footer line containing a count of the passed in argument
def print_footer(students)
    puts "Overall, we have #{students.count} great #{students.count == 1 ? "student" : "students"}"
end

# Use the methods to output the student list
#students = input_students
print_header
print(students)
print_footer(students)