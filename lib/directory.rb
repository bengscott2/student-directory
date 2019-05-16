# frozen_string_literal: true

require 'csv'

@students = []

def input_students
  puts 'Please enter the names of the students'
  puts 'To finish, just hit return twice'
  add_student_loop(STDIN.gets.chomp)
end

def add_student(name, cohort)
  @students << { name: name, cohort: cohort.to_sym }
end

def interactive_menu_selector_loop
  loop do
    print_menu
    process_selection(STDIN.gets.chomp)
  end
end

def print_menu
  puts '1. Input the students'
  puts '2. Show the students'
  puts '3. Save list of students'
  puts '4. Load list of students'
  puts '9. Exit' # No. 9 because we'll be adding more options
end

def process_selection(selection)
  case selection
  when '1'then input_students
  when '2'then show_students
  when '3'then save_students(ask_for_filename)
  when '4'then warning; load_students(ask_for_filename)
  when '9'then exit
  else puts "I don't know what you mean try again."
  end
end

def print_header
  puts 'The students of Villains Academy'
  puts '-------------'
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

def save_students(filename)
  CSV.open(filename, 'wb') do |csv|
    @students.each do |student|
      student_data = [student[:name], student[:cohort]]
      csv << student_data
    end
  end
  puts 'File succesfully saved.'
end

def ask_for_filename
  puts 'Please enter the filename you would like to use..'
  filename = STDIN.gets.chomp
  filename
end

def load_students(filename)
  @students = []
  CSV.foreach(filename) do |row|
    name, cohort = row
    add_student(name, cohort)
  end

  puts 'File successfully loaded.'
end

def get_cohort
  months = %w[january february march april may june july august september
              october november december]
  puts 'Please enter the cohort for the student'
  cohort = STDIN.gets.chomp
  if months.include?(cohort.downcase)
    return cohort.to_s.capitalize
  else
    puts "You've entered an invalid month, please try again"
    get_cohort
  end
end

def add_student_loop(name)
  # while the name is not empty, repeat this code
  until name.empty?
    # add the student hash to the array
    add_student(name, get_cohort)
    puts "Now we have #{@students.count} students"
    puts 'Please enter the name of the next student.'
    name = STDIN.gets.chomp
  end
end

def warning
  puts 'Warning: If you proceed you will lose your current working directory'
  puts "Please type 'yes' to proceed"
  input = STDIN.gets.chomp
  exit if input != 'yes'
end

def try_load_students
  filename = ARGV.first # first argument from the command line
  if filename.nil? # get out of the method if it isn't given
    puts 'Loading files from students.csv'
    load_students('students.csv')
  elsif File.exist?(filename) # if it exists
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else # if it doesn't exist
    puts "Sorry, #{filename} doesn't exist."
    exit # quit the program
  end
end


try_load_students
interactive_menu_selector_loop