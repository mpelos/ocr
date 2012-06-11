class ImageFilter
  require "RMagick"

  attr_reader :image

  def initialize(file)
    @image = Magick::ImageList.new(file).cur_image
    @pixels = @image.export_pixels
  end

  def saturate(value)
    pixels = []
    @pixels.each_slice(3) do |pixel|
      intensity = 0.299 * pixel[0] + 0.587 * pixel[1] + 0.114 * pixel[2]

      pixel.each do |color|
        pixels << limit_color(color - ((intensity - color) * 1.275))
      end
    end

    @pixels = pixels
  end

  protected

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
