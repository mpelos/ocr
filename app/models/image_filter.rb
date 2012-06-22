class ImageFilter
  require "RMagick"

  attr_reader :image, :pixels

  def initialize(file)
    @image = Magick::ImageList.new(file).cur_image
    @pixels = @image.export_pixels
    @original = true
  end

  def saturate
    if original?
      pixels = []
      @pixels.each_slice(3) do |pixel|
        intensity = 0.299 * pixel[0] + 0.587 * pixel[1] + 0.114 * pixel[2]

        pixel.each do |color|
          pixels << limit_color(color - ((intensity - color) * -1))
        end
      end

      @original, @saturated = false, true
      @pixels = pixels
    end
  end

  def binarize
    saturate if original?

    if saturated?
      threshold_value = Magick::QuantumRange / 2
      object_pixels, background_pixels = [], []

      @pixels.each_slice(3) do |pixel|
        if pixel.first >= threshold_value
          background_pixels << pixel.first
        else
          object_pixels << pixel.first
        end
      end

      background_avarage = background_pixels.inject(&:+) / background_pixels.size
      object_average = object_pixels.inject(&:+) / object_pixels.size
      threshold_value = (background_avarage + object_average) / 2

      pixels = []
      @pixels.each_slice(3) do |pixel|
        pixel.each do |color|
          if color < threshold_value
            pixels << 0
          else
            pixels << Magick::QuantumRange
          end
        end
      end

      @saturated, @binarized = false, true
      @pixels = pixels
    end

    assemble_pixels
  end

  def highlight_characters(positions)
    if binarized?
      positions.each do |position|
        (position.y..position.y + position.height).each do |y|
          (position.x..position.x + position.width).each do |x|
            current = ((y * image.columns) + x) * 3
            if y == position.y || y == (position.y + position.height) || x == position.x || x == (position.x + position.width)
              @pixels[current]     = Magick::QuantumRange # red
              @pixels[current + 1] = 0 # green
              @pixels[current + 2] = 0 # blue
            end
          end
        end
      end
    end
  end

  def save_at(path)
    assemble_pixels
    image.write(path)
  end

  def original?
    @original
  end

  def saturated?
    !!@saturated
  end

  def binarized?
    !!@binarized
  end

  protected

  def assemble_pixels
    image.import_pixels(0, 0, image.columns, image.rows, "RGB", @pixels)
  end

  def limit_color(color)
    if color > 65535
      65535
    elsif color < 0
      0
    else
      color
    end
  end
end
