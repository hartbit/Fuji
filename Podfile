platform :ios, '5.0'

target :test do
	link_with 'FujiTests'
	dependency 'Specta'
	dependency 'Expecta', :git => 'https://github.com/TrahDivad/expecta.git'
	dependency do |mockito|
		mockito.name			= 'OCMockito'
		mockito.version			= '0.22'
		mockito.source			= { :git => 'https://github.com/TrahDivad/OCMockito.git' }
		mockito.source_files	= 'Source/OCMockito/*.{h,m}'
	end
	dependency do |hamcrest|
		hamcrest.name           = 'OCHamcrest'
		hamcrest.version        = '1.8'
		hamcrest.source         = { :git => 'https://github.com/TrahDivad/OCHamcrest.git' }
		hamcrest.source_files   = 'Source/OCHamcrest.h', 'Source/Core/**/*.{h,m,mm}', 'Source/Library/**/*.{h,m,mm}'
		hamcrest.clean_paths    = 'Examples', 'Documentation', 'Source/Tests', 'Source/TestSupport'
	end
end
