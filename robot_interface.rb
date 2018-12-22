require './robot.rb'

class RobotInterface
  class << self
    def argf
      ARGF.each_line do |line|
        RobotInterface.call(line.gsub("\n", '').split(/[\s,]/))
      end
    end

    def call(args)
      case args[0]
        when 'PLACE'
          @robot ||= if args[4]
                       Robot.new(args[1].to_i, args[2].to_i, args[3]&.to_sym,
                                 table_x: args[4].to_i, table_y: args[5].to_i)
                     else
                       Robot.new(args[1].to_i, args[2].to_i, args[3]&.to_sym)
                     end
        when 'MOVE'
          @robot&.move
        when 'LEFT'
          @robot&.turn_left
        when 'RIGHT'
          @robot&.turn_right
        when 'REPORT'
          report = @robot&.report
          p "Output: #{report[:x]},#{report[:y]},#{report[:facing]}" if report
        else
          p 'Not valid'
      end
    rescue ArgumentError => e
      p e.message
    end
  end
end

RobotInterface.argf