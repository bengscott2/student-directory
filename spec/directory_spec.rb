require 'directory'

describe 'print_header' do
  it 'prints header' do
  expect { print_header }.to output("The students of Villains Academy\n-------------\n").to_stdout
  end
end

describe 'process_selection' do
  it 'will print a sorry message when a not valid switch input is passed' do
    expect {process_selection("10")}.to output("I don't know what you mean try again.\n").to_stdout
  end
end

describe 'print_footer' do
  before(:all) do
    @students = [{name: "Ben", cohort: :November}, {name: "Alexis", cohort: :November}]
  end
  it 'will output student count when 2 students are in @students' do
    expect { print_footer }.to output("Overall, we have 2 great students\n").to_stdout
  end
end

describe 'ask_for_filename' do
  context "user enters a filename" do
    let (:user_input) { "students.csv\n" }

    it "returns the user input as a filenam" do
      allow(STDIN).to receive(:gets) {user_input}
      expect(ask_for_filename).to eq("students.csv")
    end
  end
end
