require 'net/http'
require 'net/https'
require 'open-uri'
require 'hpricot'

module Meteor
  module Widget
    module RemoteContent
      class Renderer < ::Meteor::RendererBase
        
        def content
          response = Net::HTTP.get_response(URI::parse(spec.url))
          if response
            response_code = response.code
            response_code = "999" if response.body =~ /\AERROR:/
            if response_code == "200"
              return absolutize(spec.url, response.body, spec.remote_dom_id, spec.partial)
            else
              return "Made request to #{spec.url}, got response code #{response_code}" + (response_code == "999" ? "\n#{response.body}" : "")
            end
          else
            return "Error getting response for URL #{spec.url}"
          end
        end
        
        def absolutize(url, body, remote_dom_id = nil, partial = nil)
          document = Hpricot(body)
          {:img => 'src', :script => 'src', :link => 'href', :a => 'href', :form => 'action'}.each do |tag_name, attribute_name|
            (document/tag_name).each do |tag|
              attribute = tag.attributes[attribute_name]
              tag.attributes[attribute_name] = ("#{url}" + attribute) if attribute && attribute !~ /\Ahttp:\/\//
            end
          end
          (document/(remote_dom_id)).first.inner_html = @template.render(:partial => partial) if remote_dom_id && partial
          return (document/"head").first.to_s + (document/"body").first.to_s
        end
        
      end
    end
  end
end
