require 'srt'
require 'srt_parser'

module SRTParser
  class Parser
    def self.parse(file, duration)
      srt_file = SRT::File.parse(file)
      # An array of contiguous blocks of subtitled times.
      times = []

      srt_file.lines.each do |line|
        if times.last and line.start_time <= times.last[1]
          if line.end_time > times.last[1]
            times.last[1] = line.end_time
          end
        else
          times.push([ line.start_time, line.end_time ])
        end
      end

      Subtitle.new(duration, times)
    end
  end

  class Subtitle
    def initialize(duration, intervals)
      @duration = duration
      @intervals = intervals
    end

    def coverage
      covered = 0
      @intervals.each do |interval|
        covered += interval[1] - interval[0]
      end

      covered / @duration
    end
  end
end
