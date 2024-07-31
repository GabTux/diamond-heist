# frozen_string_literal: true

require_relative '../entities/map'
require_relative '../entities/player'
require_relative '../entities/object_pool'
require_relative '../entities/components/player_input'
require_relative '../entities/diamond'
require_relative 'end_state'

# This class represents the play state.
# It contains the object pool, where all game objects are stored.
# It also contains the map, which is drawn in the background.
class PlayState < GameState
  def initialize
    @map = Map.new
    @object_pool = ObjectPool.new(@map)
    @player1 = Player.new(@object_pool,
                          PlayerInput.new([Gosu::KbA, Gosu::KbD, Gosu::KbW, Gosu::KbS], Gosu::KbX),
                          { x: 50, y: $window.height - 50 }, 'Player 1', 'player.json')
    @player2 = Player.new(@object_pool,
                          PlayerInput.new([Gosu::KbLeft, Gosu::KbRight, Gosu::KbUp, Gosu::KbDown],
                                          Gosu::KbP), { x: $window.width - 50, y: $window.height - 50 },
                          'Player 2', 'player_blue.json')
    @diamond = Diamond.new(@object_pool)
    super
  end

  def enter
    music.play(true)
    music.volume = 0.05
  end

  def leave
    music.volume = 0
    music.stop
    @player1.sounds.off
    @player2.sounds.off
  end

  def music
    @music ||= Gosu::Song.new(Utils.audio_path('game_music.wav'))
  end

  def update
    @object_pool.objects.map(&:update)
    @object_pool.objects.reject!(&:removable?)
    handle_win
  end

  def draw
    @map.draw
    @object_pool.objects.map(&:draw)
  end

  def button_down(id)
    GameState.switch(MenuState.instance) if id == Gosu::KbEscape
  end

  private

  def handle_win
    if @player2.won?
      GameState.switch(EndState.new(@player2.name))
    elsif @player1.won?
      GameState.switch(EndState.new(@player1.name))
    end
  end
end
