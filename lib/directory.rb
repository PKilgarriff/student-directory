# Allows for passing default argument to use prepopulated array of student hashes
default_students = ARGV.include?('default') ? true : false
ARGV.clear

ADJECTIVES = [
  "great",
  "toxic",
  "diabolical",
  "mischievious",
  "sinister",
  "suspiscious",
  "evil",
  "scheming"
]

def interactive_menu
  loop do
    # 1. Print the menu and ask the user what to do
    puts "1. Input the students"
    puts "2. Show the students"
    puts "9. Exit program"
    # 2. Read the input and save it as a variable
    selection = gets.chomp
    # 3. Carry out the task the user has asked for
    case selection
    when 1
      input_students
    when 2
      print(students)
    when 9
      exit
    end
  end
end

# All of the student names are stored in an array
students = [
  { name: "Dr. Hannibal Lecter", cohort: :january, birthplace: "Lithuania" },
  { name: "Darth Vader", cohort: :february, birthplace: "Tatooine" },
  { name: "Nurse Ratched", cohort: :march, birthplace: "Oregon" },
  { name: "Michael Corleone", cohort: :march, birthplace: "New York" },
  { name: "Alex DeLarge", cohort: :march, birthplace: "Britain" },
  { name: "The Wicked Witch of the West", cohort: :june, birthplace: "Oz" },
  { name: "Terminator", cohort: :january, birthplace: "Los Angeles 2029" },
  { name: "Freddy Krueger", cohort: :june, birthplace: "Elm Street" },
  { name: "The Joker", cohort: :november, birthplace: "Gotham" },
  { name: "Joffrey Baratheon", cohort: :november, birthplace: "King's Landing" },
  { name: "Norman Bates", cohort: :november, birthplace: "Bates Motel" },
] if default_students

# Prompts the user for names of students and stores them in an array
def input_students
  puts 'Please enter student information'
  puts 'Enter the student name, cohort, and their place of birth, separated by commas'
  puts 'To finish, just hit return twice'
  # create an empty array
  students = []
  name = 'To be Overwritten'

  # get the first name
  # while the name is not empty, repeat this code
  until name.empty?
    name, cohort, birthplace = gets.chomp.split(",").map { |value| value.strip }
    break if name === nil

    cohort = :january if cohort === nil
    birthplace = "Unknown" if birthplace === nil
    puts "Name: #{name}, Cohort: #{cohort}, Birthplace: #{birthplace}"
    # add the student hash to the array
    students << { name: name, cohort: cohort.downcase.to_sym, birthplace: birthplace }
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
  cohorts = cohorts(students)
  cohorts.each do |cohort|
    puts cohort.capitalize
    current_cohort = students.select { |student| student[:cohort] == cohort }
    current_cohort.each { |student| puts "\t#{student[:name]}" }
  end
end

# Prints a header
def print_header
  header = 'The students of Villains Academy'
  puts header
  puts "-" * header.length
end

# Takes an array as an input and 'puts' each value within
# def print(students, starting_with)
def print(students)
  if students.count == 0
    puts 'No students are currently enrolled'
    return
  end
  longest_name = students.map { |student| student[:name] }.max_by(&:length)
  longest_birthplace = students.map { |student| student[:birthplace] }.max_by(&:length)
  students.each_with_index do |student, idx|
    # next unless student[:name].length < 12

    # if student[:name][0].downcase == starting_with.downcase
    student_output = "#{(idx + 1).to_s.ljust(2)} | "\
    "#{student[:name].center(longest_name.length)} | "\
    "#{student[:birthplace].center(longest_birthplace.length)} | "\
    "#{student[:cohort].capitalize}"
    puts student_output
  end
  # idx = 0
  # while idx < students.length
  #   student_output = "#{(idx + 1).to_s.ljust(2)} | "\
  #   "#{students[idx][:name].center(longest_name.length)} | "\
  #   "#{students[idx][:birthplace].center(longest_birthplace.length)} | "\
  #   "#{students[idx][:cohort].capitalize}"
  #   puts student_output
  #   idx += 1
  # end
end

# Puts a footer line containing a count of the passed in argument
def print_footer(students)
  return if students.count == 0

  puts "Overall, we have #{students.count} #{ADJECTIVES.sample} #{students.count == 1 ? "student" : "students"}"
end

# Use the methods to output the student list
students = input_students if students == nil
print_header
# print(students, "T")
# p cohorts(students)
print(students)
# print_by_cohort(students)
print_footer(students)