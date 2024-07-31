# frozen_string_literal: true

require_relative 'component'

# This class is responsible for drawing the bullet
class BulletGraphics < Component
  # @param [GameObject] game_object game object which this component belongs to
  def initialize(game_object)
    super(game_object)
    @game_object = game_object
    @horizontal = units.frame('horizontal.png')
    @vertical = units.frame('vertical.png')
    @body = @horizontal if object.direction.to_i == 90 || object.direction.to_i == 270
    @body = @vertical if object.direction.to_i.zero? || object.direction.to_i == 180
  end

  def draw
    @body.draw_rot(x, y, 1, 0)
  end

  private

  def units
    @units = Gosu::TexturePacker.load_json(Utils.image_path('bullet.json'))
  end
end
