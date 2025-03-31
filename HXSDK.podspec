Pod::Spec.new do |s|
  s.name             = 'HXSDK'
  s.version          = '0.0.1'
  s.summary          = 'HXSDK for iOS.'

  s.homepage         = 'https://github.com/OctMon/HXSDK-iOS'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'octmon' => 'octmon@qq.com' }
  s.source           = { :git => 'https://github.com/OctMon/HXSDK-iOS.git', :tag => s.version.to_s }

  s.swift_version = '5.0'
  
  s.ios.deployment_target = '9.0'
  
  s.ios.vendored_frameworks = 'HXSDK/Frameworks/HXSDK.framework'
  s.dependency 'UBiXMerakSDK', '~> 2.5.1'

  s.pod_target_xcconfig = { 'SWIFT_OBJC_INTERFACE_HEADER_NAME' => "$(SWIFT_MODULE_NAME).h", 'ENABLE_BITCODE' => 'NO', 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386 arm64' }
end
