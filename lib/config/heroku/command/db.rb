require 'heroku/command/db'

class Heroku::Command::Db

  def parse_db_url

    db = args.detect { |a| a.include?('HEROKU_POSTGRESQL_') } || 'DATABASE_URL'

    format = args.detect do |a|
      if a.include?("--format")
        a.split(/=?|\s?/)[1]
      end
    end

    db_info = {}

    heroku.config_vars(app).select do |k, v|
      if k.include?(db)
        db_info[:name] = k
        db_info[:conn_string] = v
      end
    end

    uri = URI.parse(db_info[:conn_string])
    uri_parts = {
      :host   => uri.host,
      :db     => cleanse_path(uri.path),
      :user   => uri.user,
      :pw     => uri.password,
      :scheme => uri.scheme,
      :port   => uri.port
    }

    return "#{uri_parts[:scheme]} not supported yet" if uri_parts[:scheme] != 'postgres'

    if format.nil? || format == "psql"

      display("psql -h #{uri_parts[:host]} -d #{uri_parts[:db]} -U #{uri_parts[:user]}")

    elsif format == 'pgpass'

      display("#{uri_parts[:host]}:#{uri_parts[:port]}:#{uri_parts[:db]}:#{uri_parts[:user]}:#{uri_parts[:pw]}")

    else

      display("#{format} not known or supported. Please use 'psql' or 'pgpass'")

    end

  end

  protected

  def cleanse_path(path)
    path.sub(/^\//,'')
  end

end
