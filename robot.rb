class Robot
  TABLE_SIZE = 5
  DIRECTIONS = [:NORTH, :EAST, :SOUTH, :WEST]

  def initialize(x, y, direction)
    validation(x, y, direction)
    self.position = {x: x, y: y}
    self.direction = direction
    self.actions = { NORTH: lambda { position[:x] += 1 if on_table?(position[:x] + 1) },
                     EAST:  lambda { position[:y] += 1 if on_table?(position[:y] + 1) },
                     SOUTH: lambda { position[:x] -= 1 if on_table?(position[:x] - 1) },
                     WEST:  lambda { position[:y] -= 1 if on_table?(position[:y] - 1) }}
  end

  def move
    actions[direction].call
  end

  def turn_left
    self.direction = actions.keys[actions.keys.index(direction) - 1]
  end

  def turn_right
    self.direction = actions.keys[actions.keys.index(direction) + 1] || actions.keys[0]
  end

  def report
    position.merge(facing: direction)
  end

  private

  attr_accessor :position, :direction, :actions

  def on_table?(value)
    value <= TABLE_SIZE && value >= 0
  end

  def validation(x, y, direction)
    unless on_table?(x) && on_table?(y) && DIRECTIONS.include?(direction.to_sym)
      raise ArgumentError.new("X,Y must be > 0 and < #{TABLE_SIZE}. Direction must be one of #{DIRECTIONS}")
    end
  end
end
