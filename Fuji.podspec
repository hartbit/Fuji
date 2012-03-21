Pod::Spec.new do |fuji|
  fuji.name     = 'Fuji'
  fuji.version  = '0.1'
  fuji.license  = 'MIT'
  fuji.summary  = 'An iOS game development framework with a clean and extensible component-base design.'
  fuji.homepage = 'http://TrahDivad.github.com/Fuji/'
  fuji.author   = { 'David Hart' => 'david@hart-dev.com' }
  fuji.source   = { :git => 'https://github.com/TrahDivad/Fuji.git' }

  fuji.platform = :ios
  fuji.clean_paths = 'Documentation', 'Tests'

  fuji.subspec 'Core' do |core|
    core.summary      = 'Fuji/Core defines the foundation upon which all other Fuji components are built.'
    core.source_files = 'Sources/Core'
  end

  fuji.subspec 'Graphics' do |graphics|
    graphics.summary  = 'Fuji/Graphics contains all components for 2d graphics drawing with OpenGL.'
    core.source_files = 'Sources/Graphics'

    dependency 'Fuji/Graphics'
  end
end