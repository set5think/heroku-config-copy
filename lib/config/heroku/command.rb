require 'heroku/command'

module Heroku
  module Command

    global_option :dst_app, "--dst_app APP" do |app|
      raise OptionParser::InvalidOption.new(app) if app == "pp"
    end

  end
end
