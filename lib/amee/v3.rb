# Copyright (C) 2008-2013 AMEE UK Ltd. - http://www.amee.com
# Released as Open Source Software under the BSD 3-Clause license. See LICENSE.txt for details.

require 'amee/v3/meta_helper'
require 'amee/v3/collection'
require 'amee/v3/connection'

# Allow v3 code to be completely disabled, for test purposes. See PL-11196
unless defined?(DISABLE_AMEECONNECT_V3)
  require 'amee/v3/item_definition'
  require 'amee/v3/item_value_definition'
  require 'amee/v3/item_value_definition_list'
  require 'amee/v3/return_value_definition'
end