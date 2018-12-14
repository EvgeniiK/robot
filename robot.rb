class Robot
  DEFAULT_TABLE_SIZE = 5

  def initialize(x, y, direction, table_x: DEFAULT_TABLE_SIZE, table_y: DEFAULT_TABLE_SIZE)
    self.actions = { NORTH: lambda { position[:x] += 1 if on_table?(table_x, position[:x] + 1) },
                     EAST:  lambda { position[:y] += 1 if on_table?(table_y, position[:y] + 1) },
                     SOUTH: lambda { position[:x] -= 1 if on_table?(table_x, position[:x] - 1) },
                     WEST:  lambda { position[:y] -= 1 if on_table?(table_y, position[:y] - 1) }}
    self.directions = actions.keys
    validation(x, y, direction, table_x, table_y)
    self.table_x, self.table_y = table_x, table_y
    self.position = {x: x, y: y}
    self.direction = direction
  end

  def move
    actions[direction].call
  end

  def turn_left
    self.direction = directions[directions.index(direction) - 1]
  end

  def turn_right
    self.direction = directions[directions.index(direction) + 1] || directions[0]
  end

  def report
    position.merge(facing: direction)
  end

  private

  attr_accessor :position, :direction, :directions, :actions, :table_x, :table_y

  def on_table?(coordinate, value)
    value <= coordinate && value >= 0
  end

  def validation(x, y, direction, table_x, table_y)
    unless on_table?(table_x,x) && on_table?(table_y,y) && directions.include?(direction&.to_sym)
      raise ArgumentError.new("X,Y must be > 0 and < Table size. Direction must be one of #{directions}")
    end
    unless table_x&.positive? && table_y&.positive?
      raise ArgumentError.new('Table size must be > 0')
    end
  end
end
