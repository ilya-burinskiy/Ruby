# frozen_string_literal: true

require_relative 'railway'
require_relative 'console_interface'
require_relative 'command_executor'

def main
  instructions = [
    '1  - Create station',
    '2  - Create train',
    '3  - Create route (enter dispatch and terminal stations)',
    '4  - Add station to route',
    '5  - Remove station from route',
    '6  - Add route to train',
    '7  - Attach carriage',
    '8  - Detach carriage',
    '9  - Move train forward',
    '10 - Move train back',
    '11 - Stop'
  ]

  cinterface = ConsoleInterface.new
  railway = Railway.new
  command_executor = CommandExecutor.new
  loop do
    cinterface.show_instructions(instructions)
    command = cinterface.read_command
    command_executor.execute(command, railway, cinterface)
    break if command == 11
  end
end

main
