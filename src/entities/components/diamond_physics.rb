# frozen_string_literal: true

# This class is responsible for handling the diamond physics
class DiamondPhysics < Component
  def initialize(game_object, object_pool)
    super(game_object)
    @game_object = game_object
    @object_pool = object_pool
  end

  def update
    return if object.captured

    handle_capture
  end

  private

  def handle_capture
    @object_pool.each do |other|
      next unless other.is_a?(Player)
      next unless other.alive # dead player cannot capture
      next unless Gosu.distance(object.x, object.y, other.x, other.y) < 50

      other.diamond = object
      object.captured = true
      break
    end
  end
end
