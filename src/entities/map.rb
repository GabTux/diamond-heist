# frozen_string_literal: true

def create_tile_type_entries(ids, type)
  ids.product([type]).to_h
end

# This class represents the map
# It is responsible for loading the map and checking if a player can move to a specific position on the map
class Map
  TILE_SIZE = 32.0

  TILE_TYPES = {}.merge(
    create_tile_type_entries([162, 163, 164, 165, 167, 178, 179, 180, 181, 183, 114, 115, 116, 130, 131, 132], :wall),
    create_tile_type_entries([90, 106, 122, 93, 94, 91, 107, 123, 95, 98, 100, 101, 105, 117, 133, 137, 82, 83, 84],
                             :flat_wall),
    create_tile_type_entries([472, 473, 488, 489, 504, 505, 469, 470, 485, 486, 501, 502], :stairs),
    create_tile_type_entries([1036, 1037, 1038, 1052, 1053, 1054, 1068, 1069, 1070], :diamond_placeholder),
    create_tile_type_entries([1086, 1087, 1105, 1106, 1121, 1122, 1086, 1087, 1102, 1103, 1016, 1032, 909, 1022,
                              925, 1006, 936, 952, 957, 973, 968, 980, 1012], :ruins),
    create_tile_type_entries([33], :baseA),
    create_tile_type_entries([34], :baseB)
  ).freeze


  def initialize
    @map = Gosu::Tiled.load_json($window, Utils.image_path('top_down.json'))
    @bottom_layer = @map.layers.instance_variable_get(:@layers)[0]
    @top_layer = @map.layers.instance_variable_get(:@layers)[1]
    # render map only once, it is static
    @render_target = Gosu.render(@map.width, @map.height) do
      @map.draw(0, 0)
    end
  end

  # @param [Integer] x x coordinate
  # @param [Integer] y y coordinate
  # @return [Boolean] true if player can move to the given coordinates, false otherwise
  def can_move_to?(x, y)
    return false if (x > @map.width) || (y > @map.height) || x.negative? || y.negative?

    !%i[wall flat_wall ruins].include?(tile_at(x, y))
  end

  def draw
    # just show previously rendered object --> no overhead
    @render_target.draw(0, 0, 0)
  end

  # @param [Integer] x x coordinate
  # @param [Integer] y y coordinate
  # @return [Symbol] tile type at the given coordinates
  def tile_at(x, y)
    t_x = (x / TILE_SIZE).floor
    t_y = (y / TILE_SIZE).round
    # send because tile_at is private in Gosu::Tiled::Layer
    # nobody knows why it is private
    top_id = @top_layer.send :tile_at, t_x, t_y
    bottom_id = @bottom_layer.send :tile_at, t_x, t_y
    return TILE_TYPES[bottom_id] if top_id&.zero?

    TILE_TYPES[top_id]
  end
end
