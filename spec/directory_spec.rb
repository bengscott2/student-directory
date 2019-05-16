require 'directory'

describe 'print_header' do
  it 'prints header' do
  expect { print_header }.to output("The students of Villains Academy\n-------------\n").to_stdout
  end
end
