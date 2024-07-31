# frozen_string_literal: true

require_relative 'component'

# This class is responsible for the bullet's physics
class BulletPhysics < Component
  # @param [GameObject] game_object game object which this component belongs to
  # @param [ObjectPool] object_pool object pool, which contains all game objects
  def initialize(game_object, object_pool)
    super(game_object)
    @object_pool = object_pool
    @map = object_pool.map
    @speed = 10
  end

  def update
    new_x, new_y = handle_movement
    check_hit(new_x, new_y)
    if @map.can_move_to?(new_x, new_y)
      object.x = new_x
      object.y = new_y
    else
      object.mark_for_removal
    end
  end

  private

  def check_hit(new_x, new_y)
    @object_pool.each do |other|
      next unless other.is_a?(Player)
      next if other == object.source # do not hit source player
      next unless other.alive # do not hit dead players

      if Gosu.distance(new_x, new_y, other.x, other.y) < @speed
        other.physics.die
        object.mark_for_removal
      end
    end
  end

  def handle_movement
    new_x = object.x
    new_y = object.y
    case @object.direction.to_i
    when 90
      new_x -= @speed
    when 270
      new_x += @speed
    when 0
      new_y -= @speed
    when 180
      new_y += @speed
    end
    [new_x, new_y]
  end
end
