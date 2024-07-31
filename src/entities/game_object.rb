# frozen_string_literal: true

# This is the base class for all game objects.
# Game objects are used to add functionality to the game, they have components.
# They are updated and drawn in the game loop, they can be removed from the game.
# They can be added to the object pool.
class GameObject
  # @param [ObjectPool] object_pool object pool, which contains all game objects
  # It will add itself to the object pool.
  def initialize(object_pool)
    @components = []
    @object_pool = object_pool
    @object_pool.objects << self
  end

  attr_reader :components

  # Update all my components.
  def update
    @components.each(&:update)
  end

  # Draw all my components.
  def draw
    @components.each(&:draw)
  end

  def removable?
    @removable
  end

  # Remove myself from the object pool.
  def mark_for_removal
    @removable = true
  end

  protected

  attr_reader :object_pool
end
