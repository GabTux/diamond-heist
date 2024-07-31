# frozen_string_literal: true

# This class is responsible for playing the player sounds
class PlayerSounds < Component
  def update
    unless object.alive
      stop_moving_sound
      return
    end

    if object.physics.moving?
      if object.physics.on_stairs?
        unless @on_stairs_sound_playing
          stop_moving_sound
          @moving_sound_instance = moving_sound_stairs.play(0.2, 1, true)
          @on_stairs_sound_playing = true
        end
      else # on grass
        unless @on_grass_sound_playing
          stop_moving_sound
          @moving_sound_instance = moving_sound.play(1, 1, true)
          @on_grass_sound_playing = true
        end
      end
    else
      stop_moving_sound
    end
  end

  def collide
    @collide_sound_instance = collide_sound.play(0.1, 1, false) unless @collide_sound_instance&.playing?
  end

  def die
    death_sound.play(0.2, 1, false)
  end

  def respawn
    respawn_sound.play(0.05, 1, false)
  end

  def off
    @moving_sound_instance&.stop
    @moving_sound_instance = nil
  end

  private

  def stop_moving_sound
    @moving_sound_instance&.stop
    @moving_sound_instance = nil
    @on_stairs_sound_playing = false
    @on_grass_sound_playing = false
  end

  def moving_sound
    @moving_sound ||= Gosu::Sample.new(Utils.audio_path('walk.wav'))
  end

  def moving_sound_stairs
    @moving_sound_stairs ||= Gosu::Sample.new(Utils.audio_path('stairs.mp3'))
  end

  def collide_sound
    @collide_sound ||= Gosu::Sample.new(Utils.audio_path('collide.mp3'))
  end

  def death_sound
    @death_sound ||= Gosu::Sample.new(Utils.audio_path('die.mp3'))
  end

  def respawn_sound
    @respawn_sound ||= Gosu::Sample.new(Utils.audio_path('respawn.mp3'))
  end
end
