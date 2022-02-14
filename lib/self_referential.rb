def print_file(filename = $0)
  # Defaults to itself ($0 gives filename of running file)
  # Open the file in 'read' mode
  file = File.open(filename, "r")
  # Iterate over the lines of the file
  file.readlines.each do |line|
    puts line
  end
  # Close the file
  file.close
end

# Call the above print_file method with no argument
print_file