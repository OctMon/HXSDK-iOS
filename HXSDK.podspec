Pod::Spec.new do |s|
  s.name             = 'HXSDK'
  s.version          = '4.3.1'
  s.summary          = 'HXSDK for iOS.'

  s.homepage         = 'https://github.com/OctMon/HXSDK-iOS'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'octmon' => 'octmon@qq.com' }
  s.source           = { :git => 'https://github.com/OctMon/HXSDK-iOS.git', :tag => s.version.to_s }

  s.ios.deployment_target = '11.0'
  
  s.vendored_frameworks = 'HXSDK.framework'
  s.source_files = 'HXSDK.framework/Headers/*.h'
  s.public_header_files = 'HXSDK.framework/Headers/*.h'
  
  s.default_subspecs = ['Core']
  
  s.subspec 'Core' do |ss|
      s.dependency 'PTGAdFramework', '~> 2.2.80'
  end
  
  s.subspec 'UBiX' do |ss|
    ss.dependency 'UBiXMerakSDK', '~> 2.5.1'
  end
  
  s.subspec 'IconAd' do |ss|
    ss.dependency 'CXHAdSDK/Channel', '~> 1.8.9'
    ss.dependency 'CXHAdSDK/RC', '~> 1.8.9'
  end
  
  s.pod_target_xcconfig = {
      'OTHER_LDFLAGS' => '$(inherited) -ObjC',
  }
  
  valid_archs = ['armv7', 'armv7s', 'x86_64', 'arm64']
  s.xcconfig = {
      'VALID_ARCHS' => valid_archs.join(' '),
  }
    
end
