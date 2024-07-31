# frozen_string_literal: true

require_relative 'game_object'
require_relative 'components/bullet_graphics'
require_relative 'components/bullet_physics'
require_relative 'components/bullet_sounds'

# This class represents a bullet
class Bullet < GameObject
  attr_accessor :x, :y, :direction, :source

  # @param [ObjectPool] object_pool object pool, which contains all game objects
  # @param [Integer] source_x x coordinate of the source
  # @param [Integer] source_y y coordinate of the source
  # @param [Integer] direction direction of the bullet
  def initialize(object_pool, source_x, source_y, direction)
    super(object_pool)
    @x = source_x
    @y = source_y
    @direction = direction
    BulletPhysics.new(self, object_pool)
    BulletGraphics.new(self)
    BulletSounds.play
  end

  def fire(source)
    @source = source
  end
end
