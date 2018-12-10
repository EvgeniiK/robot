require './robot.rb'

class RobotInterface
  def self.call(args)
    case args[0]
      when 'PLACE'
        @robot ||= Robot.new(args[1].to_i, args[2].to_i, args[3].to_sym)
      when 'MOVE'
        return unless @robot
        @robot.move
      when 'LEFT'
        return unless @robot
        @robot.turn_left
      when 'RIGHT'
        return unless @robot
        @robot.turn_right
      when 'REPORT'
        return unless @robot
        report = @robot.report
        p "Output: #{report[:x]},#{report[:y]},#{report[:facing]}"
      else
        p 'Not valid'
    end
  rescue ArgumentError => e
    p e.message
  end
end

ARGF.each_line do |line|
  RobotInterface.call(line.gsub("\n", '').split(/[\s,]/))
end