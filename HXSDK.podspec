Pod::Spec.new do |s|
  s.name             = 'HXSDK'
  s.version          = '3.1.2'
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

  s.subspec 'LY' do |ss|
    ss.dependency 'HXSDK/Core'
    ss.dependency 'PTGAdFramework', '~> 2.2.75'
  end
  
  valid_archs = ['armv7', 'armv7s', 'x86_64', 'arm64']
  s.xcconfig = {
      'VALID_ARCHS' => valid_archs.join(' '),
  }
    
end
