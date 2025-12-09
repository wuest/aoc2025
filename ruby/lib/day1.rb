# frozen_string_literal: true

module Day1
  module_function

  def part1(data)
    data.map(&method(:to_instruction))
        .reduce([50, 0]) do |(pointer, zeroes), instruction|
          new_pointer = pointer.send(*instruction) % 100
          [new_pointer, new_pointer.zero? ? zeroes + 1 : zeroes]
        end
        .last
  end

  def part2(data)
    data.map(&method(:to_instruction))
        .reduce([50, 0]) do |(pointer, zeroes), instruction|
          new_pointer = pointer.send(*instruction)
          new_zeroes = if new_pointer.negative?
                         ((new_pointer - 1) / 100).abs -
                           (pointer.zero? ? 1 : 0)
                       else
                         (new_pointer / 100) +
                           (new_pointer.zero? ? 1 : 0)
                       end

          [new_pointer % 100, zeroes + new_zeroes]
        end
        .last
  end

  def to_instruction(rotation)
    distance = rotation[1..].to_i
    instruction = rotation[0] == 'R' ? :+ : :-
    [instruction, distance]
  end
end
