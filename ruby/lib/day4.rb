# frozen_string_literal: true

module Day4
  module_function

  def part1(data)
    map = data.map { |line| line.chars.map { |c| c == '@' ? 1 : 0 } }
    (0...map.length).reduce(0) do |sum_, y|
      (0...map.first.length).reduce(sum_) do |sum, x|
        if map[y][x].nonzero?
          available = map.drop(y.zero? ? 0 : y - 1)
                         .take(y.zero? ? 2 : 3)
                         .flat_map do |row|
            row.drop(x.zero? ? 0 : x - 1)
               .take(x.zero? ? 2 : 3)
          end
          sum + (available.sum <= 4 ? 1 : 0)
        else
          sum
        end
      end
    end
  end

  def part2(data)
    map = data.map { |line| line.chars.map { |c| c == '@' ? 1 : 0 } }
    last = -1
    total = 0

    while last != total
      last = total
      total += (0...map.length).reduce(0) do |sum_, y|
        (0...map.first.length).reduce(sum_) do |sum, x|
          if map[y][x].nonzero?
            available = map.drop(y.zero? ? 0 : y - 1)
                           .take(y.zero? ? 2 : 3)
                           .flat_map do |row|
              row.drop(x.zero? ? 0 : x - 1)
                 .take(x.zero? ? 2 : 3)
            end
            if available.sum <= 4
              map[y][x] = 0
              sum + 1
            else
              sum
            end
          else
            sum
          end
        end
      end
    end

    total
  end
end
