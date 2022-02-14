require_relative 'constants'

# Allows for passing default argument to use prepopulated array of student hashes
@default_students = ARGV.include?('default') ? true : false
ARGV.clear

def print_menu
  # 1. Print the menu and ask the user what to do
  puts "1. Input the students"
  puts "2. Show the students"
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
  when '9'
    exit # Terminates program
  else
    puts "Invalid selection"
  end
end

def interactive_menu
  @students = @default_students ? STUDENTS : []
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
    @students << { name: name, cohort: cohort.downcase.to_sym, birthplace: birthplace }
    puts "Now we have #{@students.count} #{@students.count == 1 ? "student" : "students"}"
  end
end

# Return an array of the cohorts in this particular array of hashes
def cohorts
  @students.map { |student| student[:cohort] }.uniq
end

# Print the student list grouped by cohort
def print_by_cohort
  # cohorts = cohorts
  cohorts.each do |cohort|
    puts cohort.capitalize
    current_cohort = @students.select { |student| student[:cohort] == cohort }
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

# Puts a footer line containing a count of the passed in argument
def print_footer
  return if @students.count == 0

  puts "Overall, we have #{@students.count} #{ADJECTIVES.sample} #{@students.count == 1 ? "student" : "students"}"
end

puts @default_students
# Call interactive_menu to run other methods based on user input
interactive_menu