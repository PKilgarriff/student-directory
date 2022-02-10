# All of the student names are stored in an array
students = [
  "Dr. Hannibal Lecter",
  "Darth Vader",
  "Nurse Ratched",
  "Michael Corleone",
  "Alex DeLarge",
  "The Wicked Witch of the West",
  "Terminator",
  "Freddy Krueger",
  "The Joker",
  "Joffrey Baratheon",
  "Norman Bates"
]

# Prints a header
def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

# Takes an array as an input and 'puts' each value within
def print(names)
  names.each do |name|
    puts name
  end
end

# Puts a footer line containing a count of the passed in argument
def print_footer(names)
  print "Overall, we have #{names.count} great students"
end

# Use the methods to output the student list
print_header
print(students)
print_footer(students)