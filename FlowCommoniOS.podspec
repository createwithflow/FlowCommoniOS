Pod::Spec.new do |s|
  s.name             = 'FlowCommoniOS'
  s.version          = '1.12.0'
  s.summary          = 'Common files required for running any iOS project that uses Flow timelines.'

  s.homepage         = 'https://github.com/createwithflow/FlowCommoniOS.git'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Flow' => 'info@createwithflow.com' }
  s.source           = { :git => 'https://github.com/createwithflow/FlowCommoniOS.git', :tag => s.version }

  s.ios.deployment_target = '10.0'

  s.source_files = 'Sources/FlowCommoniOSFiles/*.swift'
  s.swift_version = '5.0'
end
