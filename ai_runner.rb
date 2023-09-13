require './spec/spec_helper'

human = Human.new
ai = AI.new
ai.change_difficulty("M")
coordinate = ai.pick_shot
human.board.cells[coordinate].place_ship(Ship.new("test", 2))
human.board.cells[coordinate].fire_upon
binding.pry
coordinate = ai.pick_shot
binding.pry