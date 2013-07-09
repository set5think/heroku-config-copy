require 'heroku/command'

module Heroku
  module Command

    global_option :dst_app, "--dst_app APP" do |app|
      raise OptionParser::InvalidOption.new(app) if app == "pp"
    end

    global_option :parse_style, "--parse_style STYLE"

  end
end
