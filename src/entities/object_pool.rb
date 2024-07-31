# frozen_string_literal: true

# This class represents a pool of objects.
class ObjectPool
  attr_accessor :objects, :map

  def initialize(map)
    @map = map
    @objects = []
  end

  def each(&block)
    @objects.each(&block)
  end
end
