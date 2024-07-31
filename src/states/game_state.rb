# frozen_string_literal: true

# This is the base class for all game states.
# All game states should inherit from this class and implement the methods.
# The game state is responsible for updating and drawing the game objects.
# It is also responsible for handling user input.
class GameState
  def self.switch(new_state)
    $window.state&.leave
    $window.state = new_state
    new_state.enter
  end

  def enter; end

  def leave; end

  def draw; end

  def update; end

  def needs_redraw?
    true
  end

  def button_down(id); end

end