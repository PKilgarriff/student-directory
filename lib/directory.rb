require_relative 'constants'

# # Allows for passing default argument to use prepopulated array of student hashes
# @default_students = ARGV.include?('default')
# ARGV.clear
@students = @default_students ? STUDENTS : []

def print_menu
  # Print the menu of possible user options
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the student list to file"
  puts "4. Load the student list from file"
  puts "5. Print students by cohort"
  puts "9. Exit program"
end

def show_students
  print_header
  print_students
  print_footer
end

def process(selection)
  case selection
  when '1'
    input_students
  when '2'
    show_students
  when '3'
    request_filename("save")
  when '4'
    request_filename("load")
  when '5'
    print_by_cohort
  when '9'
    quit
  else
    puts "Invalid selection"
  end
end

def quit
  puts "Exiting program..."
  exit # Terminates program
end

def try_load_students
  filename = ARGV.first || "students.csv" # first argument from command line or students.csv
  if File.exist?(filename)
    load_students(filename)
  else
    puts "Sorry, #{filename} does not exist."
    quit
  end
  ARGV.clear
end

def line_to_student_hash(string)
  name, cohort, birthplace = string.split(",").map { |value| value.strip }
  return false if name === nil
  # Henry's method of sorting cohort typos
  # unless "FAMJSOND".include?(cohort[0].upcase)

  # default values if none passed
  cohort = :january if cohort === nil
  birthplace = "Unknown" if birthplace === nil
  # Push the resulting values to the @students array
  @students << { name: name, cohort: cohort.downcase.to_sym, birthplace: birthplace }
end

def request_filename(save_load)
  puts "Which file would you like to #{save_load == "save" ? "save to" : "load from"}? Hit return to default to 'students.csv'"
  filename = gets.chomp
  filename = "students.csv" if filename.empty?
  filename += ".csv" unless filename.include?('.')
  save_load == "save" ? save_students(filename) : load_students(filename)
end

def load_students(filename = "students.csv")
  # Get Current count of students to compare after loading
  old_count = @students.count
  # Open the csv file containing student data in 'read' mode
  File.open(filename, "r") do |file|
    # Iterate over the lines of the file (1 student each line)
    file.readlines.each do |line|
      line_to_student_hash(line)
    end
  end # File closed automatically at end of block
  puts "Loaded #{@students.count - old_count} from #{filename}"
end

def save_students(filename = "students.csv")
  # Open the file to be written to in 'write' mode
  File.open(filename, "w") do |file|
    # Iterate over the array of students
    @students.each do |student|
      # Create a comma separated string of the student's name and cohort
      student_data = [student[:name], student[:cohort], student[:birthplace]]
      csv_line = student_data.join(",")
      # puts the line into the file
      file.puts csv_line
    end
  end
  puts "Student list saved to #{filename}"
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
  loop do
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
    current_cohort.each { |student| puts " - #{student[:name]}" }
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
def print_students
  if @students.count == 0
    puts 'No students are currently enrolled'
    return
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

# Puts a footer line containing a count of students
def print_footer
  return if @students.count == 0

  puts "Overall, we have #{@students.count} #{ADJECTIVES.sample} #{@students.count == 1 ? "student" : "students"}"
end

# Load students if passed filename on the commandline
try_load_students
# Call interactive_menu to run other methods based on user input
interactive_menu