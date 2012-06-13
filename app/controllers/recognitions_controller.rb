class RecognitionsController < ApplicationController
  def create
    original_image_path = "#{Rails.root}/app/assets/images/image"
    saturated_image_path = "#{Rails.root}/app/assets/images/saturated"
    `cp #{params[:image][:file].path} #{original_image_path}` if params[:image][:file].present?

    image = ImageFilter.new(original_image_path)
    image.saturate
    image.save_at(saturated_image_path)

    render :new
  end
end
