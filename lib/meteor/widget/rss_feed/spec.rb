module Meteor
  module Widget
    module RssFeed
      # You've generated a new Meteor Widget!
      #
      # Your new widget can be rendered with the following:
      #
      # <%= render_meteor_widget(::Meteor::Widget::RssFeed::Spec.new(...) -%>
      #   
      # This renders its partial, vendor/plugins/rss_feed/templates/rss_feed/_render.rhtml.
      #
      # In your partial you can get a hold of your spec object with a local call 'spec'.

      class Spec < ::Meteor::PluginSpecBase

        include MeteorWidgetPlugin

        def self.renderer_class
          ::Meteor::Widget::RssFeed::Renderer
        end
        
        attr_accessor :url
        attr_accessor :linkify
        attr_accessor :reverse

        def initialize(options={},&block)
          super(options,&block)
        end
      end
    end
  end
end
