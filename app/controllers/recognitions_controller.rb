class RecognitionsController < ApplicationController
  def create
    original_image_path = "#{Rails.root}/app/assets/images/original"
    saturated_image_path = "#{Rails.root}/app/assets/images/saturated"
    binarized_image_path = "#{Rails.root}/app/assets/images/binarized"
    highlighted_image_path = "#{Rails.root}/app/assets/images/highlighted"
    `cp #{params[:image][:file].path} #{original_image_path}` if params[:image][:file].present?

    image = ImageFilter.new(original_image_path)
    image.saturate
    image.save_at(saturated_image_path)
    image.binarize
    image.save_at(binarized_image_path)

    character_finder = CharacterFinder.new(binarized_image_path)
    image.highlight_characters(character_finder.find)
    image.save_at(highlighted_image_path)

    characters = ""
    character_finder.extract_characters_pixel_matrix.each do |character|
      characters << " #{CharacterRecognizer.new(character).recognize} "
    end

    flash[:notice] = characters

    render :new
  end
end
