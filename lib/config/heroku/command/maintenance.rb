require 'heroku/command/maintenance'

class Heroku::Command::Maintenance

  def on
    if args.empty?
      super
    else
      if args.include?('ALL')
        apps = api.get_apps.body
        unless apps.empty?
          apps.each do |my_app|
            @app = my_app['name']
            api.get_app(@app)
            action("Enabling maintenance mode for #{@app]}") do
              api.post_api_maintenance(@app, '1')
            end
          end
        end
      end
    end
  end

  def off
    if args.empty?
      super
    else
      if args.include?('ALL')
        apps = api.get_apps.body
        unless apps.empty?
          apps.each do |my_app|
            @app = my_app['name']
            api.get_app(@app)
            action("Disabling maintenance mode for #{@app}") do
              api.post_api_maintenance(@app, '0')
            end
          end
        end
      end
    end
  end

end
