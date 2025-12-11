# frozen_string_literal: true

module Day5
  module_function

  def part1(data)
    ranges, ingredients = data.slice_when { |x| x.empty? }.to_a
    fresh = ranges[0..-2].reduce([]) do |ingredients, line|
      ingredients + [line.split('-').map(&:to_i)]
    end

    ingredients.map(&:to_i)
               .reduce(0) do |sum, i|
      in_range = fresh.detect { |(start, stop)| i.between?(start, stop) }
      sum + (in_range.nil? ? 0 : 1)
    end
  end

  def part2(data)
    ranges_, _ = data.slice_when { |x| x.empty? }.to_a
    fresh = ranges_[0..-2].reduce([]) do |ranges, line|
      start, stop = line.split('-', 2).map(&:to_i)
      to_collapse = ranges.select do |start2, stop2|
        start.between?(start2, stop2) || stop.between?(start2, stop2) ||
          start2.between?(start, stop) || stop2.between?(start, stop)
      end

      if to_collapse.empty?
        ranges + [[start, stop]]
      else
        reduced = ranges.delete_if { |range| to_collapse.include?(range) }
        full = to_collapse + [[start, stop]]

        reduced + [[full.map(&:first).min, full.map(&:last).max]]
      end
    end

    fresh.reduce(fresh.length) do |sum, (start, stop)|
      sum + stop - start
    end
  end
end
