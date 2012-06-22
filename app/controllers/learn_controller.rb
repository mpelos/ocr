class LearnController < ApplicationController
  def create
    if params[:image]
      image = ImageFilter.new(params[:image][:file].path)
      character_finder = CharacterFinder.new(image.binarize)
      characters_matrix =  character_finder.extract_characters_pixel_matrix
      @characters = []

      characters_matrix.each_with_index do |character, index|
        character_recognizer = CharacterRecognizer.new(character)
        @characters[index] = CharacterData.new
        character_recognizer.density.each do |density|
          @characters[index].quadrants.build(:density => density)
        end
      end

    else
      params[:characters].each do |character_params|
        character = CharacterData.new(character_params.last)
        character.save
      end
    end

    render :new
  end
end
