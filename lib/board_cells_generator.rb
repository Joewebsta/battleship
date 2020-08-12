require './lib/cell'

class BoardCellsGenerator
  attr_reader :chars, :nums, :grid_cells, :rows
  attr_accessor :cells

  def initialize(rows)
    @cells = {}
    @rows = rows
    @grid_cells = rows**2
    @chars = ('A'..'Z').to_a.take(rows)
    @nums = (1..rows).to_a
  end

  def generate
    1.upto(grid_cells) do |cell_num|
      cells[format_coordinate] = Cell.new(format_coordinate)
      update_coordinate(cell_num)
    end

    cells
  end

  def format_coordinate
    "#{chars.first}#{nums.first}"
  end

  def update_coordinate(cell_num)
    end_of_row?(cell_num) ? update_letter_and_num : update_num
  end

  def end_of_row?(cell_num)
    (cell_num % rows).zero?
  end

  def update_letter_and_num
    "#{chars.rotate!.first}#{nums.rotate!.first}"
  end

  def update_num
    "#{chars.first}#{nums.rotate!.first}"
  end
end
