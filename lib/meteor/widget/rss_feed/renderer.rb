require 'rss'

module Meteor
  module Widget
    module RssFeed
      class Renderer < ::Meteor::RendererBase
        
        def content
          open(spec.url) {|stream| RSS::Parser.parse(stream.read, false)} rescue nil
        end
        
      end
    end
  end
end
