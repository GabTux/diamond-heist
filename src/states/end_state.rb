# frozen_string_literal: true

require 'singleton'
require_relative '../utils'
require_relative '../entities/button'
require_relative 'menu_state'
require_relative 'play_state'

# This class represents the end state.
# It is shown when a player has won the game.
class EndState < GameState
  def initialize(winner)
    @background = Gosu::Image.new(Utils.image_path('gem_win.png'))
    @message = Gosu::Image.from_text("#{winner} wins!", 100, font: Utils.font_path('LDFComicSans.ttf'))
    @width_offset = 30
    super()
  end

  def enter
    setup_buttons
  end

  def setup_buttons
    button_y = $window.height / 2 + 100
    button_gap = 60
    @buttons = [
      Button.new($window.width / 2 + @width_offset, button_y + button_gap, 'Main Menu'),
      Button.new($window.width / 2 + @width_offset, button_y + button_gap * 2, 'Quit')
    ]
  end

  def draw
    @background.draw(0, 0, 0)
    @message.draw($window.width / 2 - @message.width / 2,
                  100 - @message.height / 2,
                  10)
    @buttons.each(&:draw)
  end

  def update
    @buttons.each(&:update)
    handle_buttons
  end

  def button_down(id)
    $window.close if id == Gosu::KbEscape
  end

  def handle_buttons
    @buttons.each do |button|
      next unless button.released?

      case button.text
      when 'Main Menu'
        GameState.switch(MenuState.instance)
      when 'Quit'
        $window.close
      end
    end
  end
end
