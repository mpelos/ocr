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

    characters_positions = CharacterFinder.new(binarized_image_path).find
    image.highlight_characters(characters_positions)
    image.save_at(highlighted_image_path)

    render :new
  end
end
