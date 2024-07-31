# frozen_string_literal: true

# This module contains utility methods.
# It is used to build the path to the media files.
module Utils
  def self.media_path(file)
    File.join(File.dirname(File.dirname(__FILE__)), 'media', file)
  end

  def self.audio_path(file)
    File.join(File.dirname(File.dirname(__FILE__)), 'media', 'audio', file)
  end

  def self.font_path(file)
    File.join(File.dirname(File.dirname(__FILE__)), 'media', 'fonts', file)
  end

  def self.image_path(file)
    File.join(File.dirname(File.dirname(__FILE__)), 'media', 'images', file)
  end

  def self.button_down?(button)
    $window.button_down?(button)
  end
end
