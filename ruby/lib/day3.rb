# frozen_string_literal: true

module Day3
  module_function

  def part1(data)
    data.map { |line| line.chars.map(&:to_i) }
        .reduce(0) do |maxes, bank|
          maxes + bank.reduce([0, 0], &method(:find_max))
                      .reduce(0) { |s, e| (s * 10) + e }
        end
  end

  def part2(data)
    data.map { |line| line.chars.map(&:to_i) }
        .reduce(0) do |maxes, bank|
          maxes +
            bank.drop(12)
                .reduce(bank.take(12), &method(:find_max12))
                .reduce(0) { |s, e| (s * 10) + e }
        end
  end

  def find_max((tens, ones), digit)
    if ones > tens
      [ones, digit]
    elsif digit > ones
      [tens, digit]
    else
      [tens, ones]
    end
  end

  def find_max12(digits, digit)
    target = (1..11).detect { |n| digits[n] > digits[n - 1] }
    if target
      digits.delete_at(target - 1)
      digits + [digit]
    elsif digit > digits.last
      digits[0..-2] + [digit]
    else
      digits
    end
  end
end
