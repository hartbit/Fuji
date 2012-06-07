Pod::Spec.new do |s|
  s.name      = 'Fuji'
  s.version   = '0.0.1'
  s.license   = { :type => 'Simplified BSD', :file => 'LICENSE.md' }
  s.summary   = 'An iOS game development framework with a clean and extensible component-base design.'
  s.homepage  = 'http://TrahDivad.github.com/Fuji/'
  s.author    = { 'David Hart' => 'david@hart-dev.com' }
  s.source    = { :git => 'https://github.com/TrahDivad/Fuji.git', :commit => 'bb3ba033cf853b1734fcd347d4274bf863ccf1fb' }

  s.platform      = :ios, '5.0'
  s.source_files  = 'Fuji/Sources/**/*.{h,m}'
  s.requires_arc  = true
  s.frameworks    = ['Foundation', 'CoreGraphics', 'OpenGLES', 'GLKit', 'UIKit']
  
  s.documentation = { :appledoc => [
    '--index-desc' ]}
end