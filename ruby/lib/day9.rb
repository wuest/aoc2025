# frozen_string_literal: true

module Day9
  module_function

  def part1(data)
    points = data.map { |line| line.split(',', 2).map(&:to_i) }
    rectangles(points)
      .sort { |(size1, _), (size2, _)| size2 <=> size1 }
      .first
      .first
  end

  def part2(data)
    points = data.map { |line| line.split(',', 2).map(&:to_i) }
    edges = ((-1)...(points.length - 1)).map { |i| [points[i], points[i + 1]] }

    rectangles(points)
      .reduce(0) do |max, (size, rect)|
        if size < max
          max
        else
          valid?(edges, rect) ? size : max
        end
      end
  end

  def rectangles(points)
    (0...points.length).reduce([]) do |rects, i|
      (x1, y1) = points[i]

      ((i + 1)...points.length).reduce(rects) do |built, j|
        (x2, y2) = points[j]
        area = ((x1 - x2).abs + 1) * ((y1 - y2).abs + 1)
        built + [[area, [points[i], points[j]]]]
      end
    end
  end

  def valid?(edges, ((x1, y1), (x2, y2)))
    xmin, xmax = [x1, x2].sort
    ymin, ymax = [y1, y2].sort

    edges.each do |((ex1, ey1), (ex2, ey2))|
      exmin, exmax = [ex1, ex2].sort
      eymin, eymax = [ey1, ey2].sort

      return false if xmin < exmax && xmax > exmin && ymin < eymax && ymax > eymin
    end

    true
  end
end
