platform :ios, :deployment_target=>'5.0'

target :test do
	dependency 'Specta'
	dependency 'Expecta', :git => 'https://github.com/petejkim/expecta.git', :commit => '4b1125a71f27636b92415546c287ec4e2bd59ebb'
	dependency do |spec|
		spec.name			= 'OCMockito'
		spec.version		= '0.22'
		spec.source			= { :git => 'https://github.com/jonreid/OCMockito.git' }
		spec.source_files	= 'Source/OCMockito/*.{h,m}'
		
		spec.dependency 'OCHamcrest'
	end
end
