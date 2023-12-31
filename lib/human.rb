require './lib/player.rb'
require 'pry'

class Human < Player

  def render_board
    @board.render(true)
  end

  def place_ships
    @ships.each do |ship|
      puts "Enter the squares for the #{ship.name} (#{ship.length} spaces)"
      coordinates = gets.upcase.chomp.split(" ")
      until @board.valid_placement?(ship, coordinates) || coordinates == "quit"
        puts "That is not a valid placement, please try again!"
        coordinates = gets.upcase.chomp.split(" ")
      end
      place(ship, coordinates)
      system("clear")
      puts "==============PLAYER BOARD=============="
      puts render_board
      puts "#{ship.name} placed"
    end
    puts "All ships placed! Press enter to start game!"
    gets
  end
end