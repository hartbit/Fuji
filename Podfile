platform :ios, :deployment_target=>'5.0'

dependency 'CocoaLumberjack'

target :test do
	dependency 'Specta'
	dependency 'Expecta', :git => 'https://github.com/TrahDivad/expecta.git'
	dependency do |spec|
		spec.name			= 'OCMockito'
		spec.version		= '0.21'
		spec.source			= { :git => 'https://github.com/TrahDivad/OCMockito.git' }
		spec.source_files	= 'Source/OCMockito/*.{h,m}'
		
		spec.dependency 'OCHamcrest'
	end
end
