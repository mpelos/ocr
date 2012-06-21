module CharacterRecognizer
  def density(matrix, options = {})
    options.reverse_merge! :quadrants_quantity => 16
    densities = []

    matrix.each_with_index do |row, i|
      row.each_with_index do |pixel, j|
        current = (i * row.size) + j
        index = ((current * options[:quadrants_quantity]) / (matrix.size * row.size)).floor
        densities[index] ||= [0, 0]
        densities[index][0] += 1 if pixel == 0
        densities[index][1] += 1
      end
    end

    densities.map { |density| density.first / density.last.to_f }
  end
end
