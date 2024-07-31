# frozen_string_literal: true

require_relative 'game_object'
require_relative 'components/player_graphics'
require_relative 'components/player_physics'
require_relative 'components/player_sounds'
require_relative 'bullet'

# This class represents a player.
class Player < GameObject
  SHOOT_DELAY = 500 # milliseconds
  SPEED = 3

  attr_accessor :x, :y, :sounds, :physics, :body, :moving, :direction, :visible, :alive, :diamond
  attr_reader :name

  # @param [ObjectPool] object_pool object pool, which contains all game objects
  # @param [Input] input input handler
  # @param [Hash] spawn_point spawn point
  # @param [String] name player name
  # @param [String] json_file json file name which contains the player's sprites
  def initialize(object_pool, input, spawn_point, name, json_file)
    super(object_pool)
    @input = input
    @input.control(self)
    @sounds = PlayerSounds.new(self)
    @physics = PlayerPhysics.new(self, object_pool, spawn_point)
    @graphics = PlayerGraphics.new(self, json_file)
    @direction = 180
    @visible = false
    @alive = true
    @name = name
  end

  # Shoots a bullet if possible.
  def shoot
    return unless can_shoot?

    Bullet.new(object_pool, x, y, direction).fire(self)
    @last_shot = Gosu.milliseconds
    @physics.make_visible_for_a_while
  end

  # @return [Boolean] true if the player has won, false otherwise
  def won?
    !diamond.nil? && @physics.at_base?
  end

  private

  def can_shoot?
    return false unless alive

    Gosu.milliseconds - (@last_shot || 0) > SHOOT_DELAY
  end
end
