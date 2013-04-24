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
            action("Enabling maintenance mode for #{my_app['name']}") do
              api.post_app_maintenance(my_app['name'], '1')
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
            action("Disabling maintenance mode for #{my_app['name']}") do
              api.post_app_maintenance(my_app['name'], '0')
            end
          end
        end
      end
    end
  end

end
