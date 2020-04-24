Pod::Spec.new do |s|
  s.name             = 'FlowCommoniOS'
  s.version          = '0.0.2'
  s.summary          = 'Common files required for running any iOS project that uses Flow timelines.'

  s.homepage         = 'https://github.com/SlantDesign/FlowCommoniOS.git'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Flow' => 'info@createwithflow.com' }
  s.source           = { :git => 'https://github.com/SlantDesign/FlowCommoniOS.git', :tag => s.version }

  s.ios.deployment_target = '10.0'

  s.source_files = 'FlowCommon/FlowCommonFiles/*.swift'
  s.swift_version = '5.0'
end
