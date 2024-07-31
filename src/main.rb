# frozen_string_literal: true

require 'gosu'
require 'gosu_tiled'
require 'gosu_texture_packer'

require_relative 'states/game_state'
require_relative 'states/menu_state'
require_relative 'states/play_state'
require_relative 'game_window'

# I know working with global variables, but only one window is in program.
$window = GameWindow.new
GameState.switch(MenuState.instance)
$window.show
