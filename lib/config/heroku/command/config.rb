require 'heroku/command/config'

class Heroku::Command::Config
  # config:copy --dst_app APP
  #
  # copies config from one app to another
  #
  #Examples:
  #
  # $ heroku config:copy --dst_app APP
  # one
  #

  def copy
    unless dst_app.empty?
      vars = api.get_config_vars(app).body
      if vars.empty?
        display("#{app} has no config vars.")
      else
        vars.each {|key, value| vars[key] = value.to_s}
        action("Setting config vars and restarting #{dst_app}") do
          api.put_config_vars(dst_app, vars)
          @status = begin
            if release = api.get_release(dst_app, 'current').body
              release['name']
            end
          rescue Heroku::API::Errors::RequestFailed => e
          end
        end
      end
    end
  end
end
