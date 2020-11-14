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
    '5  - Add route to train',
    '6  - Remove station from route',
    '7  - Attach carriage (and create)',
    '8  - Detach carriage',
    '9  - Move train forward',
    '10 - Move train back',
    '11 - Show train carriages',
    '12 - Show trains on station',
    '13 - Reserve seat',
    '14 - Load carriage',
    '15 - Stop'
  ]

  cinterface = ConsoleInterface.new
  railway = Railway.new
  command_executor = CommandExecutor.new
  loop do
    begin
      cinterface.show_instructions(instructions)
      command = cinterface.read_command
      command = command_executor.decode_command(command)
      command_executor.execute_command(command, railway, cinterface)
    rescue StandardError => e
      cinterface.show_msg(e.message)
      command = :stop
    end

    break if command == :stop
  end
end

main
