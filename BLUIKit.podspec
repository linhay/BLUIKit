Pod::Spec.new do |s|
s.name             = 'BLUIKit'
s.version          = '0.2.0'
s.summary          = '自定义UI组件'

s.homepage         = 'https://github.com/bigL055/BLUIKit.git'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'linger' => 'linhan.bigl055@outlook.com' }
s.source           = { :git => 'https://github.com/bigL055/BLUIKit.git', :tag => s.version.to_s }

s.ios.deployment_target = '8.0'
s.frameworks = 'UIKit'

s.subspec 'TextInput' do |ss|
  
  ss.subspec 'Core' do |sss|
    sss.source_files = 'Sources/TextInput/Core/*.swift'
  end
  
  ss.subspec 'TextField' do |sss|
    sss.source_files = 'Sources/TextInput/TextField/*.swift'
  end
  
  ss.subspec 'TextView' do |sss|
    sss.source_files = 'Sources/TextInput/TextView/*.swift'
  end
  
  ss.subspec 'SearchBar' do |sss|
    sss.source_files = 'Sources/TextInput/SearchBar/*.swift'
  end
  
end

s.pod_target_xcconfig = { 'SWIFT_VERSION' => '4.0' }
end

