require File.dirname(__FILE__) + '/spec_helper.rb'

test_set = {
  'attrib_test/@attrib' => 'attribute_value',
  'attrib_test/@non_existent_attrib' => nil,
  'attrib_test/@empty_attrib' => '',
  'content_test' => 'content',
  'whitespace_content_test' => "\n    ",
  'empty_content_test' => nil,
  'self_closing_content_test' => nil,
  'multi_attrib_test/attrib_test/@attrib' => [
      'attribute_value',
      'attribute_value_1',
      ''
    ],
  'multi_content_test/content' => [
      'content',
      "\n        ",
      nil,
      nil
    ],
}

class REXMLTestObject
  include ParseHelper
  def xmlpathpreamble
    '/root/'
  end
  def initialize
    @doc = REXML::Document.new(fixture('parse_test.xml'))
  end
end

describe ParseHelper, 'using REXML' do

  before :all do
    @obj = REXMLTestObject.new
  end

  test_set.each_pair do |xpath, res|
    it "should parse #{xpath} to #{res}" do
      @obj.send(:x, xpath).should eql res
    end
  end


end
