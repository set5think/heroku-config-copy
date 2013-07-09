require 'heroku/command/db'

class Heroku::Command::Db

  def parse_db_url

    db = args.detect { |a| a.include?('HEROKU_POSTGRESQL_') } || 'DATABASE_URL'

    (db_name, db_string) = heroku.config_vars(app).select { |k, v| k.include?(db) }

    puts db_name
    puts db_string

    # uri = URI.parse(db_string)
    # uri_parts = {
    #   :host   => uri.host,
    #   :db     => cleanse_path(uri.path),
    #   :user   => uri.user,
    #   :pw     => uri.password,
    #   :scheme => uri.scheme,
    #   :port   => uri.port
    # }

    # return "#{uri_parts['scheme']} not supported yet" if uri_parts['scheme'] != 'postgres'

    # if parse_style.nil? || parse_style == "psql"
    #   return "psql -h #{uri_parts['host']} -d #{uri_parts['db']} -U #{uri_parts['user']}"
    # elsif parse_style == 'pgpass'
    #   return "#{uri_parts['host']}:#{uri_parts['port']}:#{uri_parts['db']}:#{uri_parts['user']}:#{uri_parts['pw']}"
    # else
    #   return "#{parse_style} not known or supported. Please use 'psql' or 'pgpass'"
    # end
  end

  protected

  def cleanse_path(path)
    path.sub(/^\//,'')
  end

end
