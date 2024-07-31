# frozen_string_literal: true

require_relative 'game_object'
require_relative 'components/diamond_graphics'
require_relative 'components/diamond_physics'

# This class represents a diamond
class Diamond < GameObject

  attr_accessor :x, :y, :captured

  def initialize(object_pool)
    super(object_pool)
    @x = 562
    @y = 60
    DiamondGraphics.new(self)
    DiamondPhysics.new(self, object_pool)
    @captured = false
  end
end
