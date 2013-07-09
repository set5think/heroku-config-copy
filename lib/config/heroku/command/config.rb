require 'heroku/command/config'

class Heroku::Command::Config
  # config:copy --dst_app APP [KEY1 KEY1]
  #
  # copies config from one app to another
  #
  #Examples:
  #
  # $ heroku config:copy --dst_app APP
  #
  # $ heroku config:copy --dst_app APP DATABASE_URL #This will just copy DATABASE_URL from --app to --dst_app
  #

  def copy
    unless dst_app.empty?
      vars = api.get_config_vars(app).body
      if vars.empty?
        display("#{app} has no config vars.")
      else
        vars.each {|key, value| vars[key] = value.to_s}
        unless args.empty?
          vars = vars.select {|key, value| args.include?(key) }
        end
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

  def parse_db_url
    require 'uri'
    uri = URI.parse(opts[:database_url])
    uri_parts = {
      :host   => uri.host,
      :db     => cleanse_path(uri.path),
      :user   => uri.user,
      :pw     => uri.password,
      :scheme => uri.scheme,
      :port   => uri.port
    }

    return "#{uri_parts['scheme']} not supported yet" if uri_parts['scheme'] != 'postgres'

    if parse_style.nil? || parse_style == "psql"
      return "psql -h #{uri_parts['host']} -d #{uri_parts['db']} -U #{uri_parts['user']}"
    elsif parse_style == 'pgpass'
      return "#{uri_parts['host']}:#{uri_parts['port']}:#{uri_parts['db']}:#{uri_parts['user']}:#{uri_parts['pw']}"
    else
      return "#{parse_style} not known or supported. Please use 'psql' or 'pgpass'"
    end
  end

  protected

  def cleanse_path(path)
    path.sub(/^\//,'')
  end

end
