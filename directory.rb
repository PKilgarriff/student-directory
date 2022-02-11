# All of the student names are stored in an array
 students = [
   {name: "Dr. Hannibal Lecter", cohort: :january, birthplace: "Lithuania"},
   {name: "Darth Vader", cohort: :february, birthplace: "Tatooine"},
   {name: "Nurse Ratched", cohort: :march, birthplace: "Oregon"},
   {name: "Michael Corleone", cohort: :march, birthplace: "New York"},
   {name: "Alex DeLarge", cohort: :march, birthplace: "Britain"},
   {name: "The Wicked Witch of the West", cohort: :june, birthplace: "Oz"},
   {name: "Terminator", cohort: :january, birthplace: "Los Angeles 2029"},
   {name: "Freddy Krueger", cohort: :june, birthplace: "Elm Street"},
   {name: "The Joker", cohort: :november, birthplace: "Gotham"},
   {name: "Joffrey Baratheon", cohort: :november, birthplace: "King's Landing"},
   {name: "Norman Bates", cohort: :november, birthplace: "Bates Motel"},
 ]

# Prompts the user for names of students and stores them in an array
def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # create an empty array
  students = []
  name = "To be Overwritten"

  # get the first name
  # while the name is not empty, repeat this code
  while !name.empty? do
    name, cohort, birthplace = gets.chomp.split(",").map { |value| value.strip }
    break if name === nil

    cohort = :january if cohort === nil
    birthplace = "Unknown" if birthplace === nil
    puts "Name: #{name}, Cohort: #{cohort}, Birthplace: #{birthplace}"
    # add the student hash to the array
    students << {name: name, cohort: cohort.downcase.to_sym, birthplace: birthplace}
    puts "Now we have #{students.count} #{students.count == 1 ? "student" : "students"}"
  end
  # return the array of students
  students
end

# Return an array of the cohorts in this particular array of hashes
def cohorts(students)
  students.map { |student| student[:cohort] }.uniq
end

# Print the student list grouped by cohort
def print_by_cohort(students)

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
  if students.count == 0
    puts "No students are currently enrolled"
    break
  end
  longest_name = students.map { |student| student[:name] }.max_by(&:length)
  longest_birthplace = students.map { |student| student[:birthplace] }.max_by(&:length)
  students.each_with_index do |student, idx|
    # if student[:name].length < 12
    # if student[:name][0].downcase == starting_with.downcase
      # puts "#{idx + 1}. #{student[:name]} from #{student[:birthplace]} (#{student[:cohort].capitalize} cohort)"
      student_output = "#{(idx + 1).to_s.ljust(2)} | "\
      "#{student[:name].center(longest_name.length)} | "\
      "#{student[:birthplace].center(longest_birthplace.length)} | "\
      "#{student[:cohort].capitalize}"
      puts student_output
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
p cohorts(students)
print(students)
print_footer(students)