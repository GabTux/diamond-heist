# frozen_string_literal: true

# This class represents a button that can be clicked.
# It is used in the menu screens.
class Button
  attr_reader :x, :y, :width, :height, :text

  # Create a new button at the given position with the given text.
  # @param x [Integer] the x position of the button
  # @param y [Integer] the y position of the button
  # @param text [String] the text to display on the button
  # @return [Button] the new button
  # @example
  #  Button.new(100, 100, 'Click me!')
  def initialize(x, y, text)
    @x = x
    @y = y
    @text = text
    @normal_color = Gosu::Color::WHITE
    @hover_color = Gosu::Color::CYAN
    @normal_image = Gosu::Image.from_text(text, 50, font: Utils.font_path('LDFComicSans.ttf'))
    @hover_image = Gosu::Image.from_text(text, 60, font: Utils.font_path('LDFComicSansBold.ttf'))
    @width = @normal_image.width + 20
    @height = @normal_image.height + 10
    @current_image = @normal_image
    @current_color = @normal_color
    @was_mouse_pressed = false
  end

  # This method checks if the mouse is over the button and if the button is released.
  # It updates the button's size and color accordingly.
  def update
    @current_image = @normal_image
    @current_color = @normal_color
    if mouse_over?
      @current_image = @hover_image
      @current_color = @hover_color
      if Gosu.button_down?(Gosu::MsLeft)
        @was_mouse_pressed = true
      elsif @was_mouse_pressed
        @was_mouse_pressed = false
        @mouse_released = true
      else
        @mouse_released = false
      end
    else
      @was_mouse_pressed = false
      @mouse_released = false
    end
  end

  def draw
    @current_image.draw(@x - @width / 2 + 10, @y - @height / 2 + 5, 1, 1, 1, @current_color)
  end

  # @return [Boolean] true if the mouse is over the button and the button is released
  # @example
  #  if button.released?
  #    puts 'Button was clicked!'
  #  end
  def released?
    if @mouse_released
      @mouse_released = false
      return true
    end
    false
  end

  private

  def mouse_over?
    mx = $window.mouse_x
    my = $window.mouse_y
    mx >= @x - @width / 2 && mx <= @x + @width / 2 && my >= @y - @height / 2 && my <= @y + @height / 2
  end
end
