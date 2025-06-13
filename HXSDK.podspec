Pod::Spec.new do |s|
  s.name             = 'HXSDK'
  s.version          = '2.0.0'
  s.summary          = 'HXSDK for iOS.'

  s.homepage         = 'https://github.com/OctMon/HXSDK-iOS'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'octmon' => 'octmon@qq.com' }
  s.source           = { :git => 'https://github.com/OctMon/HXSDK-iOS.git', :tag => s.version.to_s }

  s.swift_version = '5.0'
  
  s.ios.deployment_target = '11.0'
  
  s.default_subspec = ['Core']
  
  s.subspec 'Core' do |ss|
    ss.ios.vendored_frameworks = 'HXSDK/Frameworks/HXSDK.framework'
  end

  s.subspec 'PTGAd' do |ss|
    ss.dependency 'HXSDK/Core'
    ss.dependency 'PTGAdFramework', '~> 2.2.75'
  end

  s.pod_target_xcconfig = { 'SWIFT_OBJC_INTERFACE_HEADER_NAME' => "$(SWIFT_MODULE_NAME).h", 'ENABLE_BITCODE' => 'NO', 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386 arm64' }
end
