# frozen_string_literal: true

module Day7
  module_function

  def part1(data)
    init = data.first
               .chars
               .map { |c| c == 'S' ? 1 : 0 }

    data[1..].map(&:chars)
             .each_with_index
             .reject { |(_, index)| index.even? }
             .map(&:first)
             .reduce([0, init], &method(:split_beam))
             .first
  end

  def part2(data)
    init = data.first
               .chars
               .map { |c| c == 'S' ? 1 : 0 }

    data[1..].map(&:chars)
             .each_with_index
             .reject { |(_, index)| index.even? }
             .map(&:first)
             .reduce([0, init], &method(:split_beam))
             .last
             .sum
  end

  def split_beam((count, state), line)
    current = state.zip(line)
    current.each_with_index
           .reduce([count, []]) do |(sum, newstate), (space, index)|
             if space.last == '.'
               left = current[index - 1]
               right = current[index + 1] || [0, '.']
               newcount = space.first + (left.last == '^' ? left.first : 0) + (right.last == '^' ? right.first : 0)
               [sum, newstate + [newcount]]
             elsif space.first.nonzero?
               [sum + 1, newstate + [0]]
             else
               [sum, newstate + [0]]
             end
           end
  end
end
