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
            action("Enabling maintenance mode for #{my_app}") do
              api.post_appi_maintenance(my_app, '1')
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
            action("Disabling maintenance mode for #{my_app}") do
              api.post_appi_maintenance(my_app, '0')
            end
          end
        end
      end
    end
  end

end
