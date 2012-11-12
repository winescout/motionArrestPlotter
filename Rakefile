# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project'
require 'bubble-wrap'

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'motionArrestsPlotter'
  app.info_plist['UIMainStoryboardFile'] = 'MainStoryboard'
  app.frameworks += [
    'MapKit',
    'AddressBook',
    'libz.dylib',
    'MobileCoreServices',
    'SystemConfiguration',
    'CFNetwork'
  ]
end
