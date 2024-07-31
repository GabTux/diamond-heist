# frozen_string_literal: true

# This class is responsible for playing the bullet sound
class BulletSounds
  class << self
    def play
      sound.play(0.1, 1, false)
    end

    private

    def sound
      @sound ||= Gosu::Sample.new(Utils.audio_path('bullet.mp3'))
    end
  end
end
