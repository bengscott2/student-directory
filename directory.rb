@students = []

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  add_student_loop(STDIN.gets.chomp)
end

def interactive_menu_selector_loop
  loop do
    print_menu
    process_selection(STDIN.gets.chomp)
  end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "9. Exit" # No. 9 because we'll be adding more options
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print_students_list
  @students.each do |student|
    puts "#{student[:name]} (#{student[:cohort]} cohort)"
  end
end

def print_footer
  puts "Overall, we have #{@students.count} great students"
end

def show_students
  print_header
  print_students_list
  print_footer
end

def process_selection(selection)
  case selection
  when "1"
    students = input_students
  when "2"
    show_students
  when "3"
    save_students(ask_for_filename)
  when "4"
    load_students(ask_for_filename)
  when "9"
    exit
  else
    puts "I don't know what you mean try again."
  end
end

def save_students(filename)
  # open the file for writing
  file = File.open(filename, "w")
  # iterate over the array of students
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  puts "File succesfully saved."
  file.close
end

def ask_for_filename
  puts "Please enter the filename you would like to use.."
  filename = STDIN.gets.chomp
  filename
end

def load_students(filename)
  file = File.open(filename, "r")
  file.readlines.each do |line|
    name, cohort = line.chomp.split(',')
    add_student(name, cohort)
  end
  puts "File successfully loaded."
  file.close
end

def add_student(name, cohort)
  @students << {name: name, cohort: cohort.to_sym}
end

def add_student_loop(name)
  # while the name is not empty, repeat this code
  while !name.empty? do
    # add the student hash to the array
    add_student(name, :november)
    puts "Now we have #{@students.count} students"
    # get another name from the user
    name = STDIN.gets.chomp
  end
end

def try_load_students
  filename = ARGV.first # first argument from the command line
  if filename.nil? # get out of the method if it isn't given
    puts "Loading files from students.csv"
    load_students("students.csv")
  elsif File.exists?(filename) # if it exists
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else # if it doesn't exist
    puts "Sorry, #{filename} doesn't exist."
    exit # quit the program
  end
end

try_load_students
interactive_menu_selector_loop
