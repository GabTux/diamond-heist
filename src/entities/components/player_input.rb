# frozen_string_literal: true

require_relative 'component'

# This class is responsible for handling the player input
class PlayerInput < Component
  # @param [Array<Integer>] motion_buttons array of buttons which control the player movement
  # @param [Integer] shoot_button button which controls the player shooting
  def initialize(motion_buttons, shoot_button)
    super()
    @motion_buttons = motion_buttons
    @shoot_button = shoot_button
  end

  def control(obj)
    self.object = obj
  end

  def update
    if any_button_down?(*@motion_buttons)
      object.moving = true
      change_direction(*@motion_buttons)
    else
      object.moving = false
    end
    object.shoot if Utils.button_down?(@shoot_button)
  end

  private

  def any_button_down?(*buttons)
    buttons.any? { |b| Utils.button_down?(b) }
  end

  def change_direction(left, right, up, down)
    if Utils.button_down?(left)
      object.direction = 90.0
    elsif Utils.button_down?(right)
      object.direction = 270.0
    elsif Utils.button_down?(up)
      object.direction = 0.0
    elsif Utils.button_down?(down)
      object.direction = 180.0
    end
  end
end
