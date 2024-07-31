# frozen_string_literal: true

# This class represents the game window it inherits from Gosu::Window and sets the parameters.
# It also implements the methods needed by Gosu::Window.
class GameWindow < Gosu::Window
  attr_accessor :state

  def initialize
    super(960, 640)
    self.caption = 'Diamond Heist'
  end

  def update
    @state.update
  end

  def draw
    @state.draw
  end

  def needs_redraw?
    @state.needs_redraw?
  end

  def button_down(id)
    @state.button_down(id)
  end
end
