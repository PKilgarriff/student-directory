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
# Print the list of students
puts "The students of Villains Academy"
puts "-------------"
students.each do |student|
  puts student
end
# Finally print the total number of students
print "Overall, we have #{students.count} great students"