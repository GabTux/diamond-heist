# frozen_string_literal: true

require_relative 'component'

# This class is responsible for drawing the diamond
class DiamondGraphics < Component
  def initialize(game_object)
    super(game_object)
    @game_object = game_object
    @body = Gosu::Image.new(Utils.image_path('gem.png'))
  end

  def draw
    @body.draw_rot(object.x, object.y, 0, 5 * Math.sin(Gosu.milliseconds / 133.7)) unless object.captured
  end
end
