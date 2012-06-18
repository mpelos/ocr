class CharacterRecognizer
  attr_reader :image

  def initialize(file)
    @image = Magick::ImageList.new(file).cur_image
    @pixels = @image.export_pixels(0, 0, @image.columns, @image.rows, "R")
  end

  def horizontal_projection
    projection = []

    @pixels.each_slice(image.rows) do |row|
      projection << row.inject(0) { |count, color| color == 0 ? count + 1 : count }
    end

    projection
  end

  def vertical_projection
    projection = []
    image.columns.times { projection << 0 }

    @pixels.each_slice(image.rows) do |row|
      row.each_with_index do |color, index|
        projection[index] += 1 if color == 0
      end
    end

    projection
  end
end
