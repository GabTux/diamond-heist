# frozen_string_literal: true

require_relative 'component'

# This class is responsible for drawing the player
class PlayerGraphics < Component
  # @param [GameObject] game_object game object which this component belongs to
  # @param [String] json_file json file name which contains the player's sprites
  def initialize(game_object, json_file)
    super(game_object)
    @json_file = json_file
    @down = units.frame('down.png')
    @up = units.frame('up.png')
    @left = units.frame('left.png')
    @right = units.frame('right.png')
    @body = @down
    @diamond_img = Gosu::Image.new(Utils.image_path('gem.png'))
  end

  def update
    unless object.alive
      text = '†'
      font_size = 50
      @body = Gosu::Image.from_text(text, font_size, align: :center)
      return
    end

    @body = case object.direction.to_i
            when 90
              @left
            when 270
              @right
            when 0
              @up
            when 180
              @down
            end
  end

  def draw
    return unless object.visible

    @body.draw_rot(x, y, 1, 0)
    @diamond_img.draw_rot(x, y, 1, 0, 0.5, -0.5, 0.35, 0.35) if object.diamond&.captured
  end

  private

  def units
    @units = Gosu::TexturePacker.load_json(Utils.image_path(@json_file))
  end
end
