class CharacterFinder
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

  def vertical_projection(options = {})
    projection = []
    image.columns.times { projection << 0 }

    options[:range] ||= 0..image.columns
    starting = options[:range].first * image.columns
    ending = options[:range].last * image.columns

    @pixels[starting..ending].each_slice(image.rows) do |row|
      row.each_with_index do |color, index|
        projection[index] += 1 if color == 0
      end
    end

    projection
  end

  def find
    positions = []
    rectangle = nil

    characters_rows.each do |row|
      vertical_projection(:range => (row.y..row.y + row.height)).each_with_index do |projection, index|
        unless projection.zero?
          rectangle = Rectangle.new(index, row.y, nil, row.height) unless rectangle
        else
          if rectangle
            rectangle.width = index - rectangle.x - 1
            positions << rectangle
            rectangle = nil
          end
        end
      end
    end

    positions
  end

  protected

  def characters_rows
    rows = []
    rectangle = nil

    horizontal_projection.each_with_index do |projection, index|
      unless projection.zero?
        rectangle = Rectangle.new(0, index, image.columns, nil) unless rectangle
      else
        if rectangle
          rectangle.height = index - rectangle.y - 1
          rows << rectangle
          rectangle = nil
        end
      end
    end

    rows
  end
end
