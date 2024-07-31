# frozen_string_literal: true

require 'singleton'
require_relative '../utils'
require_relative '../entities/button'
require_relative 'about_state'

# This class represents the menu state.
# It is shown at the start of the game.
class MenuState < GameState
  include Singleton
  attr_accessor :play_state

  def initialize
    @message = Gosu::Image.from_text('Diamond Heist', 100, font: Utils.font_path('LDFComicSans.ttf'))
    @background = Gosu::Image.new(Utils.image_path('gem_in_forest.png'))
    @by_text = Gosu::Image.from_text('By Gab', 30, font: Utils.font_path('LDFComicSans.ttf'))
    @width_offset = 30
    @going_to_play = false
    super
  end

  def setup_buttons
    button_y = $window.height / 2 - @message.height / 2 + 150
    button_gap = 60
    @buttons = []
    if @play_state
      @buttons << Button.new($window.width / 2 + @width_offset, button_y, 'Continue')
      button_y += button_gap
    end
    @buttons << Button.new($window.width / 2 + @width_offset, button_y, 'New Game')
    button_y += button_gap
    @buttons << Button.new($window.width / 2 + @width_offset, button_y, 'About')
    button_y += button_gap
    @buttons << Button.new($window.width / 2 + @width_offset, button_y, 'Quit')
  end

  def enter
    music.play(true)
    music.volume = 0.1
    setup_buttons
  end

  def leave
    return unless @going_to_play

    music.volume = 0
    music.stop
  end

  def music
    @music ||= Gosu::Song.new(Utils.audio_path('menu_music.wav'))
  end

  def update
    @buttons.each(&:update)
    handle_buttons
  end

  def draw
    @background.draw(0, 0, 0)
    @message.draw($window.width / 2 - @message.width / 2 + @width_offset,
                  100 - @message.height / 2,
                  10)
    @by_text.draw($window.width - @by_text.width,
                  $window.height - @by_text.height,
                  10)
    @buttons.each(&:draw)
  end

  def handle_buttons
    @buttons.each do |button|
      next unless button.released?

      case button.text
      when 'Continue'
        if @play_state
          @going_to_play = true
          GameState.switch(@play_state)
        end
      when 'New Game'
        @going_to_play = true
        @play_state = PlayState.new
        GameState.switch(@play_state)
      when 'About'
        @going_to_play = false
        GameState.switch(AboutState.instance)
      when 'Quit'
        $window.close
      end
    end
  end
end
