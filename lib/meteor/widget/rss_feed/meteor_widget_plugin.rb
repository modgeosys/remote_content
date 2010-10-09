module Meteor
  module Widget
    module RssFeed
      module MeteorWidgetPlugin
        def plugin_name
          # XXX - I assume this will break down under heavy load; then name of the plugin this widget is found in.
          # This helps determine the render path for the template.
          'remote_content'
        end
      end
    end
  end
end

