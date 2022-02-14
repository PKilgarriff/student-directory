require_relative 'constants'

# # Allows for passing default argument to use prepopulated array of student hashes
# @default_students = ARGV.include?('default') ? true : false
# ARGV.clear
@students = @default_students ? STUDENTS : []

def print_menu
  # Print the menu of possible user options
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the student list to students.csv"
  puts "4. Load the student list from students.csv"
  puts "5. Print students by cohort"
  puts "9. Exit program"
end

def show_students
  print_header
  print_students
  print_footer
end

def process(selection)
  success = case selection
  when '1'
    input_students
  when '2'
    show_students
  when '3'
    save_students
  when '4'
    load_students
  when '5'
    print_by_cohort
  when '9'
    exit # Terminates program
  else
    puts "Invalid selection"
    continue
  end
  if success
    puts "Operation successful"
  else
    puts "Operation failed"
  end
end

def try_load_students
  filename = ARGV.first || "students.csv" # first argument from command line or students.csv
  if File.exists?(filename)
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else
    puts "Sorry, #{filename} does not exist."
    exit # quit the program
  end
  ARGV.clear
end

def line_to_student_hash(string)
  name, cohort, birthplace = string.split(",").map { |value| value.strip }
  return false if name === nil

  # default values if none passed
  cohort = :january if cohort === nil
  birthplace = "Unknown" if birthplace === nil
  # Push the resulting values to the @students array
  @students << { name: name, cohort: cohort.downcase.to_sym, birthplace: birthplace }
end

def load_students(filename = "students.csv")
  # Open the csv file containing student data in 'read' mode
  file = File.open(filename, "r")
  # Iterate over the lines of the file (1 student each line)
  file.readlines.each do |line|
    line_to_student_hash(line)
  end
  # Close the file
  file.close
end

def save_students
  # Open the file to be written to in 'write' mode
  file = File.open("students.csv", "w")
  # Iterate over the array of students
  @students.each do |student|
    # Create a comma separated string of the student's name and cohort
    student_data = [student[:name],student[:cohort],student[:birthplace]]
    csv_line = student_data.join(",")
    # puts the line into the file
    file.puts csv_line
  end
  # Close the file
  file.close
end

def interactive_menu
  loop do
    print_menu
    # 2. Read the input and save it as a variable
    selection = gets.chomp
    # 3. Carry out the task the user has asked for
    process(selection)
  end
end

# Prompts the user for names of students and stores them in an array
def input_students
  puts 'Please enter student information'
  puts 'Enter the student name, cohort, and their place of birth, separated by commas'
  puts 'To finish, just hit return twice'
  input = 'To be Overwritten'
  # while the user input is not empty, repeat this code
  until input.empty?
    input = gets.chomp
    break unless line_to_student_hash(input)
    puts "Now we have #{@students.count} #{@students.count == 1 ? "student" : "students"}"
  end
end

# Return an array of the cohorts in this particular array of hashes
def cohorts
  @students.map { |student| student[:cohort] }.uniq
end

# Print the student list grouped by cohort
def print_by_cohort
  cohorts.each do |cohort|
    puts cohort.capitalize
    current_cohort = @students.select { |student| student[:cohort] == cohort }
    current_cohort.each { |student| puts "\t#{student[:name]}" }
  end
  true
end

# Prints a header
def print_header
  header = 'The students of Villains Academy'
  puts header
  puts "-" * header.length
end

# Takes an array as an input and 'puts' each value within
# def print(students, starting_with)
def print_students
  if @students.count == 0
    puts 'No students are currently enrolled'
    return false
  end
  longest_name = @students.map { |student| student[:name] }.max_by(&:length)
  longest_birthplace = @students.map { |student| student[:birthplace] }.max_by(&:length)
  @students.each_with_index do |student, idx|
    student_output = "#{(idx + 1).to_s.ljust(2)} | "\
    "#{student[:name].center(longest_name.length)} | "\
    "#{student[:birthplace].center(longest_birthplace.length)} | "\
    "#{student[:cohort].capitalize}"
    puts student_output
  end
end

# Puts a footer line containing a count of the passed in argument
def print_footer
  return if @students.count == 0

  puts "Overall, we have #{@students.count} #{ADJECTIVES.sample} #{@students.count == 1 ? "student" : "students"}"
end

# Load students if passed filename on the commandline
try_load_students
# Call interactive_menu to run other methods based on user input
interactive_menu