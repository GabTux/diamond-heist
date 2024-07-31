# frozen_string_literal: true

# This class is responsible for handling the player physics
class PlayerPhysics < Component
  attr_accessor :speed

  VISIBILITY_DELAY = 1000 # milliseconds
  SPAWN_DELAY = 2000 # milliseconds

  def initialize(game_object, object_pool, spawn_point)
    super(game_object)
    @object_pool = object_pool
    @map = object_pool.map
    @spawn_point = spawn_point
    @base = @map.tile_at(spawn_point[:x], spawn_point[:y])
    @speed = 3
    @visibility_timer = 0
    respawn
  end

  # @param [Integer] x x coordinate
  # @param [Integer] y y coordinate
  # @return [Boolean] true if player can move to the given coordinates, false otherwise
  def can_move_to?(x, y)
    @map.can_move_to?(x, y)
  end

  def moving?
    object.moving
  end

  def update
    unless object.alive
      handle_respawn
      return
    end

    if object.moving
      new_x, new_y = handle_movement
      if @map.can_move_to?(new_x, new_y)
        object.x = new_x
        object.y = new_y
      else
        object.sounds.collide
        make_visible_for_a_while
      end
    end

    handle_visibility
  end

  def make_visible_for_a_while
    object.visible = true
    @visibility_timer = Gosu.milliseconds + VISIBILITY_DELAY
  end

  def die
    object.sounds
    object.sounds.die
    object.visible = true
    object.alive = false
    object.diamond&.captured = false
    object.diamond = nil
    @spawn_timer = Gosu.milliseconds + SPAWN_DELAY
  end

  def handle_respawn
    return unless Gosu.milliseconds > @spawn_timer

    respawn
  end

  def at_base?
    @map.tile_at(object.x, object.y) == @base
  end

  def on_stairs?
    @map.tile_at(object.x, object.y) == :stairs
  end

  private

  def respawn
    object.alive = true
    object.visible = false
    object.x = @spawn_point[:x]
    object.y = @spawn_point[:y]
    object.sounds.respawn
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

  def handle_visibility
    current_tile = @map.tile_at(object.x, object.y)
    if %i[diamond_placeholder].push(@base).include?(current_tile)
      object.visible = true
    elsif Gosu.milliseconds > @visibility_timer
      object.visible = false
    end
  end
end
