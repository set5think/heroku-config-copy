require 'heroku/command/base'

class Heroku::Command::Base

  def dst_app
    @dst_app ||= if options[:dst_app].is_a?(String)
      options[:dst_app]
    end
  end

end
