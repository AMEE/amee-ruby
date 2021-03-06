# Copyright (C) 2008-2013 AMEE UK Ltd. - http://www.amee.com
# Released as Open Source Software under the BSD 3-Clause license. See LICENSE.txt for details.

module ParseHelper
  
  def x(xpath,options = {})
    doc = options[:doc] || @doc
    preamble = options[:meta] == true ? metaxmlpathpreamble : xmlpathpreamble
    if doc.is_a?(Nokogiri::XML::Node)
      nodes = doc.xpath("#{preamble}#{xpath}")
    else
      nodes=REXML::XPath.match(doc,"#{preamble}#{xpath}")
    end
    if nodes.is_a? String
      return nodes
    end
    if nodes.length==1
      return node_value(nodes.first)
    elsif nodes.length>1
      return nodes.map{|x| node_value(x)}
    else
      return nil
    end
  end
  
  def node_value(node)
    if node.is_a?(Nokogiri::XML::Attr) || node.is_a?(REXML::Attribute)
      # Attributes are allowed to be an empty string
      return node.to_s
    elsif node.is_a?(Nokogiri::XML::Element) || node.is_a?(REXML::Element)
      return node.text == '' ? nil : node.text
    else
      return node.to_s
    end
  end

  def xmlpathpreamble
    ''
  end
  
  def load_xml_doc(xml)
    doc = Nokogiri.XML(xml) { |config| config.strict }
    doc.remove_namespaces!
    doc
  end
  private :x
  
end