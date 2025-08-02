Pod::Spec.new do |s|
  s.name             = 'HXSDK'
  s.version          = '4.0.1'
  s.summary          = 'HXSDK for iOS.'

  s.homepage         = 'https://github.com/OctMon/HXSDK-iOS'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'octmon' => 'octmon@qq.com' }
  s.source           = { :git => 'https://github.com/OctMon/HXSDK-iOS.git', :tag => s.version.to_s }

  s.ios.deployment_target = '11.0'
  
  s.vendored_frameworks = 'HXSDK.framework'
  s.source_files = 'HXSDK.framework/Headers/*.h'
  s.public_header_files = 'HXSDK.framework/Headers/*.h'
  
  valid_archs = ['armv7', 'armv7s', 'x86_64', 'arm64']
  s.xcconfig = {
      'VALID_ARCHS' => valid_archs.join(' '),
  }
    
end
