module AMEE
  module Data
    class ItemValue < AMEE::DataObject

      def initialize(data = {})
        @value = data ? data[:value] : nil
        @type = data ? data[:type] : nil
        @from_profile = data ? data[:from_profile] : nil
        @from_data = data ? data[:from_data] : nil
        super
      end

      attr_reader :type

      def value
        case type
        when "DECIMAL"
          @value.to_f
        else
          @value
        end
      end

      def from_profile?
        @from_profile
      end
      
      def from_data?
        @from_data
      end
      
      def self.from_json(json, path)
        # Read JSON
        doc = JSON.parse(json)['itemValue']
        data = {}
        data[:uid] = doc['uid']
        data[:created] = DateTime.parse(doc['created'])
        data[:modified] = DateTime.parse(doc['modified'])
        data[:name] = doc['name']
        data[:path] = path.gsub(/^\/data/, '')
        data[:value] = doc['value']
        data[:type] = doc['itemValueDefinition']['valueDefinition']['valueType']
        # Create object
        ItemValue.new(data)
      rescue 
        raise AMEE::BadData.new("Couldn't load DataItemValue from JSON. Check that your URL is correct.")
      end
      
      def self.from_xml(xml, path)
        # Read XML
        doc = REXML::Document.new(xml)
        data = {}
        data[:uid] = REXML::XPath.first(doc, "/Resources/DataItemValueResource/ItemValue/@uid").to_s
        data[:created] = DateTime.parse(REXML::XPath.first(doc, "/Resources/DataItemValueResource/ItemValue/@Created").to_s)
        data[:modified] = DateTime.parse(REXML::XPath.first(doc, "/Resources/DataItemValueResource/ItemValue/@Modified").to_s)
        data[:name] = REXML::XPath.first(doc, '/Resources/DataItemValueResource/ItemValue/Name').text
        data[:path] = path.gsub(/^\/data/, '')
        data[:value] = REXML::XPath.first(doc, '/Resources/DataItemValueResource/ItemValue/Value').text
        data[:type] = REXML::XPath.first(doc, '/Resources/DataItemValueResource/ItemValue/ItemValueDefinition/ValueDefinition/ValueType').text
        data[:from_profile] = REXML::XPath.first(doc, '/Resources/DataItemValueResource/ItemValue/ItemValueDefinition/FromProfile').text == "true" ? true : false
        data[:from_data] = REXML::XPath.first(doc, '/Resources/DataItemValueResource/ItemValue/ItemValueDefinition/FromData').text == "true" ? true : false
        # Create object
        ItemValue.new(data)
      rescue 
        raise AMEE::BadData.new("Couldn't load DataItemValue from XML. Check that your URL is correct.")
      end

      def self.get(connection, path)
        # Load data from path
        response = connection.get(path)
        # Parse data from response
        data = {}
        if response.is_json?
          value = ItemValue.from_json(response, path)
        else
          value = ItemValue.from_xml(response, path)
        end
        # Store connection in object for future use
        value.connection = connection
        # Done
        return value
      rescue
        raise AMEE::BadData.new("Couldn't load DataItemValue. Check that your URL is correct.")
      end

    end
  end
end