class CharacterRecognizer
  def initialize(matrix)
    @matrix = matrix
  end

  def density(options = {})
    options.reverse_merge! :quadrants_quantity => 9
    densities = []

    @matrix.each_with_index do |row, i|
      row.each_with_index do |pixel, j|
        current = (i * row.size) + j
        index = ((current * options[:quadrants_quantity]) / (@matrix.size * row.size)).floor
        densities[index] ||= [0, 0]
        densities[index][0] += 1 if pixel == 0
        densities[index][1] += 1
      end
    end

    densities.compact.map { |density| density.first / density.last.to_f }
  end

  def recognize(options = {})
    options.reverse_merge! :tolerance => 10
    match_character = "*"

    CharacterData.all.each do |character|
      index = -1

      match = character.quadrants.all? do |quadrant|
        index += 1
        tolerance = density[index] * (options[:tolerance].to_f / 100)
        quadrant.density <= density[index] + tolerance && quadrant.density >= density[index] - tolerance
      end

      if match
        match_character = character
        break
      end
    end

    match_character.to_s
  end
end
