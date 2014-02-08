Pod::Spec.new do |s|
  s.name         = "QROAuth"
  s.version      = "0.0.1"
  s.summary      = "Yet Another OAuth Library"
  s.description  = <<-DESC
====

Yet Another OAuth Library
                   DESC
  s.homepage     = "<>"
  #  s.screenshots  = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license      = 'MIT'
  s.author       = { "Taro Kobayashi" => "9re.3000@gmail.com" }
  s.source       = { :git => "https://github.com/9re/QROAuth.git", :tag => s.version.to_s }

  s.platform     = :ios, '6.0'
  # s.ios.deployment_target = '5.0'
  # s.osx.deployment_target = '10.7'
  s.requires_arc = true

  s.source_files = ['Classes/**/*.m', 'Classes/**/*.c', 'Classes/**/*.h']
  s.resources = ['Assets/**/*.xib']

  s.ios.exclude_files = 'Classes/osx'
  s.osx.exclude_files = 'Classes/ios'
  s.public_header_files = 'Classes/**/*.h'
  # s.frameworks = 'SomeFramework', 'AnotherFramework'
  s.dependency 'AFNetworking', '~> 2.0'
end
