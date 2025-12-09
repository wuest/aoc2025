# frozen_string_literal: true

module Day2
  module_function

  def part1(data)
    data.join
        .split(',')
        .lazy
        .map(&method(:to_range))
        .flat_map(&:to_a)
        .reduce(0) do |sum, value|
          if value.length.even? && value[0, value.length / 2] == value[(value.length / 2)..]
            sum + value.to_i
          else
            sum
          end
        end
  end

  def part2(data)
    data.join
        .split(',')
        .lazy
        .map(&method(:to_range))
        .flat_map(&:to_a)
        .reduce(0) do |sum, value|
          if repeats?(value)
            sum + value.to_i
          else
            sum
          end
        end
  end

  def to_range(datum)
    datum.split('-')
         .reduce(&:upto)
  end

  def repeats?(value)
    (1..(value.length / 2)).detect do |length|
      (value.length % length).zero? &&
        value == value[0, length] * (value.length / length)
    end
  end
end
