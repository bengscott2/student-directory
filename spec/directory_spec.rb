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
