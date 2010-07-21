module AMEE
  module Admin

    class ItemValueDefinitionList < AMEE::Collection
      # TODO this class does not yet page through multiple pages
      def initialize(connection,uid,options={})
        @uid=uid
        super(connection,options)
      end
      def klass
        ItemValueDefinition
      end
      def collectionpath
        "/definitions/itemDefinitions/#{@uid}/itemValueDefinitions"
      end

      def jsoncollector
        @doc['itemValueDefinitions']
      end
      def xmlcollectorpath
        '/Resources/ItemValueDefinitionsResource/ItemValueDefinitions/ItemValueDefinition'
      end

      def parse_json(p)
        data = {}
        data[:itemdefuid] = @uid
        data[:uid] = p['uid']
        data[:name] = p['name']
        data[:path] = p['path']
        data[:unit] = p['unit']
        data[:perunit] = p['perunit']
        data[:valuetype] = p['valueDefinition']['valueType']
        data=ItemValueDefinition.parsetype(data,p['drillDown'],p['fromProfile'],p['fromData'])
        
      end
      def parse_xml(p)
        data = {}
        data[:itemdefuid] = @uid
        data[:uid] = x '@uid',:doc => p
        data[:name] = x 'Name',:doc => p  || data[:uid]
        data[:path] = x 'Path',:doc => p
        data[:unit] = x 'Unit',:doc => p
        data[:perunit] = x 'PerUnit',:doc => p
        data[:valuetype] =x 'ValueDefinition/ValueType',:doc => p
        drill=(x('DrillDown',:doc => p)=='true')
        profile=(x('FromProfile',:doc => p)=='true')
        ldata=(x('FromData',:doc => p)=='true')
        data=ItemValueDefinition.parsetype(data,drill,profile,ldata)
        
      end
    end

    class ItemValueDefinition < AMEE::Object

      def initialize(data = {})
        @itemdefuid=data[:itemdefuid]
        @name = data[:name]
        @uid = data[:uid]
        @path = data[:path]
        @type = data[:type]
        @unit = data[:unit]
        @perunit = data[:perunit]
        @valuetype = data[:valuetype]
        @default = data[:default] == "" ? nil : data[:default]
        @choices = data[:choices] || []
        @versions = data[:versions] || []
        super
      end

      attr_reader :name,:uid,:path,:itemdefuid, :type, :valuetype, :unit, :perunit, :type, :default, :choices, :versions

      def profile?
        type=='profile'
      end

      def data?
        type=='data'
      end

      def drill?
        type=='drill'
      end

      def self.list(connection)
        ItemValueDefinitionList.new(connection)
      end

      def self.parse(connection, response, is_list = true)
        # Parse data from response
        if response.is_json?
          item_definition = ItemValueDefinition.from_json(response)
        else
          item_definition = ItemValueDefinition.from_xml(response, is_list)
        end
        # Store connection in object for future use
        item_definition.connection = connection
        # Done
        return item_definition
      end

      def self.from_json(json)
        # Read JSON
        doc = JSON.parse(json)
        data = {}
        p=doc['itemValueDefinition']
        data[:uid] = p['uid']
        data[:itemdefuid] = p['itemDefinition']['uid']
        data[:created] = DateTime.parse(p['created'])
        data[:modified] = DateTime.parse(p['modified'])
        data[:name] = p['name']
        data[:path] = p['path']
        data[:unit] = p['unit']
        data[:perunit] = p['perUnit']
        data[:valuetype] = p['valueDefinition']['valueType']
        data[:default] = p['value']
        data[:choices] = p['choices'].split(',')
        data[:versions] = p['apiVersions'].map{|v| v['apiVersion']}
        data=ItemValueDefinition.parsetype(data,p['drillDown'],p['fromProfile'],p['fromData'])
        # Create object
        ItemValueDefinition.new(data)
      rescue
        raise AMEE::BadData.new("Couldn't load ItemValueDefinition from JSON. Check that your URL is correct.\n#{json}")
      end

      def self.parsetype(data,drill,profile,ldata)
        ( (profile && !(drill||ldata) ) || ldata) or raise 'inconsistent type'
        data[:type]='profile' if profile
        data[:type]='data' if ldata
        data[:type]='drill' if drill
        data
      end

      def self.from_xml(xml, is_list = true)
        prefix = is_list ? "/Resources/ItemValueDefinitionsResource/" : "/Resources/ItemValueDefinitionResource/"
        # Parse data from response into hash
        doc = REXML::Document.new(xml)
        data = {}
        data[:uid] = REXML::XPath.first(doc, prefix + "ItemValueDefinition/@uid").to_s
        data[:itemdefuid] = REXML::XPath.first(doc, prefix + "ItemValueDefinition/ItemDefinition/@uid").to_s
        data[:created] = DateTime.parse(REXML::XPath.first(doc, prefix + "ItemValueDefinition/@created").to_s)
        data[:modified] = DateTime.parse(REXML::XPath.first(doc, prefix + "ItemValueDefinition/@modified").to_s)
        data[:name] = REXML::XPath.first(doc, prefix + "ItemValueDefinition/Name").text
        data[:path] = REXML::XPath.first(doc, prefix + "ItemValueDefinition/Path").text
        uxml=REXML::XPath.first(doc, prefix + "ItemValueDefinition/Unit")
        data[:unit] = uxml ? uxml.text : nil
        puxml=data[:perunit] = REXML::XPath.first(doc, prefix + "ItemValueDefinition/PerUnit")
        data[:perunit] = puxml ? puxml.text : nil
        data[:valuetype] = REXML::XPath.first(doc, prefix + "ItemValueDefinition/ValueDefinition/ValueType").text
        data[:default] = REXML::XPath.first(doc, prefix + "ItemValueDefinition/Value").text
        data[:choices] = REXML::XPath.first(doc, prefix + "ItemValueDefinition/Choices").text.split(',') rescue nil
        data[:versions] = REXML::XPath.each(doc, prefix + "ItemValueDefinition/APIVersions/APIVersion").map{|v| v.text}
        drill=(REXML::XPath.first(doc, prefix + "ItemValueDefinition/DrillDown").text=='true')
        profile=(REXML::XPath.first(doc, prefix + "ItemValueDefinition/FromProfile").text=='true')
        ldata=(REXML::XPath.first(doc, prefix + "ItemValueDefinition/FromData").text=='true')
        data=parsetype(data,drill,profile,ldata)
        # Create object
        ItemValueDefinition.new(data)
      rescue
        raise AMEE::BadData.new("Couldn't load ItemValueDefinition from XML. Check that your URL is correct.\n#{xml}")
      end

      def self.get(connection, path, options = {})
        # Load data from path
        response = connection.get(path, options).body
        # Parse response
        item_definition = ItemValueDefinition.parse(connection, response, false)
        # Done
        return item_definition
      rescue
        raise AMEE::BadData.new("Couldn't load ItemValueDefinition. Check that your URL is correct.\n#{response}")
      end

 

      def self.load(connection,itemdefuid,ivduid,options={})
        ItemValueDefinition.get(connection,"/definitions/itemDefinitions/#{itemdefuid}/itemValueDefinitions/#{ivduid}",options)
      end

      def reload(connection)
        ItemValueDefinition.load(connection,itemdefuid,uid)
      end

      def self.update(connection, path, options = {})
        raise AMEE::NotSupported
        #        # Do we want to automatically fetch the item afterwards?
        #        get_item = options.delete(:get_item)
        #        get_item = true if get_item.nil?
        #        # Go
        #        response = connection.put(path, options)
        #        if get_item
        #          if response.body.empty?
        #            return ItemValueDefinition.get(connection, path)
        #          else
        #            return ItemValueDefinition.parse(connection, response.body)
        #          end
        #        end
        #      rescue
        #        raise AMEE::BadData.new("Couldn't update ItemValueDefinition. Check that your information is correct.\n#{response}")
      end

      def self.create(connection,itemdefuid, options = {})
        raise AMEE::NotSupported
        #        unless options.is_a?(Hash)
        #          raise AMEE::ArgumentError.new("Second argument must be a hash of options!")
        #        end
        #        # Send data
        #        response = connection.post("/definitions/itemDefinitions/#{itemdefuid}/itemValueDefintions", options).body
        #        # Parse response
        #        item_value_definition = ItemValueDefinition.parse(connection, response)
        #        # Get the ItemValueDefinition again
        #        return ItemValueDefinition.load(connection,itemdefuid , item_value_definition.uid)
        #      rescue
        #        raise AMEE::BadData.new("Couldn't create ItemValueDefinition. Check that your information is correct.\n#{response}")
      end

      def self.delete(connection, itemdefuid,item_value_definition)
        raise AMEE::NotSupported
        #        # Deleting takes a while... up the timeout to 120 seconds temporarily
        #        t = connection.timeout
        #        connection.timeout = 120
        #        connection.delete("/definitions/itemDefinitions/#{itemdefuid}/itemValueDefinitions/" + item_value_definition.uid)
        #        connection.timeout = t
        #      rescue
        #        raise AMEE::BadData.new("Couldn't delete ItemValueDefinition. Check that your information is correct.")
      end

    end

  end

end
