# frozen_string_literal: true

module Day6
  module_function

  def part1(data)
    data.map(&method(:parse))
        .transpose
        .map(&method(:solve))
        .sum
  end

  def part2(data)
    instructions = data.last
                       .split(/\s+/)
                       .map(&:to_sym)

    numbers = data[0..-2].map(&:chars)
                         .transpose
                         .map { |chars| chars.all? { |c| c == ' ' } ? nil : chars.join }
                         .reduce([[]], &method(:build_problems))

    numbers.zip(instructions)
           .map { |(ns, instruction)| ns.reduce(instruction) }
           .sum
  end

  def parse(line)
    symbols = line.split(/\s+/)
    if ['+', '*'].include?(symbols.first)
      symbols.map(&:to_sym)
    else
      symbols.map(&:to_i)
    end
  end

  def solve(problem)
    problem[0..-2].reduce(&problem.last)
  end

  def build_problems(numbers, number)
    return numbers + [[]] if number.nil?

    numbers[0..-2] + [numbers.last + [number.to_i]]
  end
end
