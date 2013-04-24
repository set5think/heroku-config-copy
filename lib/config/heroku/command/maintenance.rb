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
            @app = api.get_app(my_app['name'])
            action("Enabling maintenance mode for #{@app}") do
              api.post_app_maintenance(@app, '1')
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
            @app = api.get_app(my_app['name'])
            action("Disabling maintenance mode for #{@app}") do
              api.post_app_maintenance(@app, '0')
            end
          end
        end
      end
    end
  end

end
