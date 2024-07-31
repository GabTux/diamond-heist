# frozen_string_literal: true

# This is the base class for all components.
# Components are used to add functionality to game objects.
class Component
  # @param [GameObject] game_object game object which the component belongs to
  def initialize(game_object = nil)
    self.object = game_object
  end

  def update
    # pure virtual
  end

  def draw
    # pure virtual
  end

  protected

  attr_reader :object

  # This method is used to set the game object which the component belongs to and add the component.
  def object=(obj)
    return unless obj

    @object = obj
    @object.components << self
  end

  def x
    @object.x
  end

  def y
    @object.y
  end
end
