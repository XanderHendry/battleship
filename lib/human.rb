require './lib/player.rb'
require 'pry'

class Human < Player

  def render_board
    @board.render(true)
  end

  def place
    @ships.each do |ship|
      puts "Enter the squares for the #{ship.name} (#{ship.length} spaces)"
      coordinates = gets.chomp.split(" ")
      until @board.valid_placement?(ship, coordinates) || coordinates == "quit"
        puts "That is not a valid placement, please try again!"
        coordinates = gets.chomp
      end
      super(ship, coordinates)
      puts "==============PLAYER BOARD=============="
      puts render_board
      puts "#{ship.name} placed, press enter to move on!"
      gets
    end
    puts "==============PLAYER BOARD=============="
    puts render_board
    puts "All ships placed! Press enter to start game!"
    gets
  end
end