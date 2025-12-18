# frozen_string_literal: true

require 'set'

module Day8
  module_function

  def part1(data)
    distances(data)
      .sort
      .take(1000)
      .map(&:last)
      .reduce(&method(:connect))
      .map(&:length)
      .sort { |x, y| y <=> x }
      .take(3)
      .reduce(&:*)
  end

  def part2(data)
    fold = method(:connect_to_size).curry.call(data.length)
    distances(data).sort
                   .map(&:last)
                   .reduce([nil, []], &fold)
                   .first
                   .map(&:first)
                   .reduce(&:*)
  end

  def distances(data)
    dists = Set.new
    vecs = data.map { |line| line.split(',', 3).map(&:to_i) }
    (0...vecs.length).each do |i|
      nodea = vecs[i]
      ((i + 1)...vecs.length).each do |j|
        nodeb = vecs[j]
        dist = nodea.zip(nodeb)
                    .map { |m, n| (m - n)**2 }
                    .sum
        dists << [dist, [nodea, nodeb]]
      end
    end

    dists
  end

  def connect(circuits, conn)
    a, b = conn
    connected = circuits.select { |circuit| circuit.include?(a) || circuit.include?(b) }

    connected.each { |c| circuits.delete(c) }
    new_circuit = connected.reduce(Set.new, &:+)
    new_circuit << conn.first
    new_circuit << conn.last

    circuits + [new_circuit]
  end

  def connect_to_size(count, (answer, circuits), conn)
    return [answer, []] if answer

    new_circuit = connect(circuits, conn)
    if new_circuit.length == 1 && new_circuit.first.length == count
      [conn, nil]
    else
      [nil, new_circuit]
    end
  end
end
