# frozen_string_literal: true

require 'singleton'
require_relative '../utils'
require_relative '../entities/button'

# This class represents the about state.
# It is shown when the user clicks on the about button in the menu state.
class AboutState < GameState
  include Singleton

  def initialize
    @background_image = Gosu::Image.new(Utils.image_path('gem_in_forest.png'))
    @back_button = Button.new(200, 600, 'Back')
    @info_text = Gosu::Image.from_text(
      "Diamond Heist\n\n" \
        "Ruby Version: #{RUBY_VERSION}\n" \
        "Gosu Version: #{Gosu::VERSION}\n\n" \
        "How to Play:\n" \
        "- Objective: Collect the diamond and return to your base.\n" \
        "- Stealth: You are invisible by default.\n" \
        "- Visibility: Become visible when shooting or hitting an obstacle. Visible near diamond.\n" \
        "- Sound: Listen to steps to locate the other player. Different steps on stairs.\n" \
        "- Press 'Escape' during play to pause.\n\n" \
        "Player 1:\n" \
        "- Movement: 'W', 'A', 'S', 'D'\n" \
        "- Shoot: Press 'X'\n\n" \
        "Player 2:\n" \
        "- Movement: Arrow keys\n" \
        "- Shoot: Press 'P'\n\n" \
        'Have good ears and happy heisting!',
      23,
      font: Utils.font_path('LDFComicSans.ttf')
    )
    super
  end

  # Update the button and switch to the menu state if the button is pressed
  def update
    @back_button.update
    return unless @back_button.released?

    GameState.switch(MenuState.instance)
  end

  def draw
    @background_image.draw(0, 0, 0)
    @info_text.draw(480 - @info_text.width / 2, 50, 1)
    @back_button.draw
  end

  def button_down(id)
    GameState.switch(MenuState.instance) if id == Gosu::KbEscape
  end
end
