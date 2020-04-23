Pod::Spec.new do |s|
  s.name             = 'FlowCommon'
  s.version          = '0.0.1'
  s.summary          = 'Common files required for running any iOS project that uses Flow timelines.'

  s.homepage         = 'https://github.com/SlantDesign/FlowCommon.git'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Flow' => 'info@createwithflow.com' }
  s.source           = { :git => 'https://github.com/SlantDesign/FlowCommon.git', :tag => s.version }

  s.ios.deployment_target = '10.0'

  s.source_files = 'FlowCommonFiles/**/*'
  s.swift_version = '5.0'
end
