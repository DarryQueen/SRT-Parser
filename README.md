# SRT Parser
A nifty tool to get SRT coverage from a video. Still in the works!

## Getting started
Add SRT Parser to your Gemfile with:

```ruby
gem 'srt_parser'
```

## Usage
Parse a given SRT file with a specified video duration:
```ruby
subtitle = SRTParser::Parser.parse(File.new('MY_SRT_FILENAME.srt'), duration)
```

Then, to get the coverage from that file:
```ruby
coverage = subtitle.coverage
```

## Contributing
1. Fork it!
2. Create your feature branch (`git checkout -b my-new-feature`).
3. Commit your changes (`git commit -am 'Add some feature'`).
4. Push to the branch (`git push origin my-new-feature`).
5. Create new Pull Request.
