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
          times.last[1] = [times.last[1], line.end_time].max
        else
          times.push([line.start_time, line.end_time])
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

    # Accessors:
    def duration
      @duration
    end
    def intervals
      @intervals
    end

    def coverage
      covered = 0
      @intervals.each do |interval|
        covered += interval[1] - interval[0]
      end

      covered / @duration
    end

    # Merge lists of intervals. Going to this in a very disgusting way:
    def self.merge(*subtitles)
      intervals = subtitles.map { |subtitle| subtitle.intervals }
        .inject([]) { |all, intervals| all.concat(intervals) }
        .sort_by { |interval| interval[0] }

      # Start merging the intervals. Totally not DRY:
      times = []

      intervals.each do |interval|
        if times.last and interval[0] <= times.last[1]
          times.last[1] = [times.last[1], interval[1]].max
        else
          times.push(Array.new(interval))
        end
      end

      durations = subtitles.map { |subtitle| subtitle.duration }
      Subtitle.new(durations.max, times)
    end
  end
end
