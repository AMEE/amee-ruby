module AMEE
  module Admin

    class ItemValueDefinitionList < AMEE::Collection

      def initialize_with_v3(connection,uid,options={})
        @use_v3_connection = true
        initialize_without_v3(connection, uid, options)
      end
      alias_method_chain :initialize, :v3

      def collectionpath
        "/#{AMEE_API_VERSION}/definitions/#{@uid}/values;full"
      end

      def xmlcollectorpath
        '/Representation/ItemValueDefinitions/ItemValueDefinition'
      end

      def parse_json(p)
        raise AMEE::NotSupported
      end
      
      def parse_xml(p)
        # This should really be handed off to ItemValueDefinition fully
        data = {}
        data[:itemdefuid] = @uid
        data[:uid] = x '@uid',:doc => p
        data[:name] = x 'Name',:doc => p  || data[:uid]
        data[:path] = x 'Path',:doc => p
        data[:default] = x 'Value',:doc => p
        data[:unit] = x 'Unit',:doc => p
        data[:perunit] = x 'PerUnit',:doc => p
        data[:valuetype] =x 'ValueDefinition/ValueType',:doc => p
        data[:choices] =(x('Choices',:doc => p)||'').split(',')        
        data[:versions] =[(x('Versions/Version/Version',:doc => p))].flatten
        data[:meta] = {}
        data[:meta][:wikidoc]=x 'WikiDoc', :doc => p
        names = x('Usages/Usage/Name', :doc => p)
        types = x('Usages/Usage/Type', :doc => p)
        data[:meta][:usages] = names && types ? Hash[*(names.zip(types.map{|x| x.downcase.to_sym})).flatten] : {}
        data[:drill]=(x('DrillDown',:doc => p)=='true')
        data[:from_profile]=(x('FromProfile',:doc => p)=='true')
        data[:from_data]=(x('FromData',:doc => p)=='true')
        data
      end
    end
    
  end
end