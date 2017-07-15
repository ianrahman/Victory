platform :ios, '11.0'

target 'Victory' do
    use_frameworks!

    pod 'Realm', :git => "https://github.com/realm/realm-cocoa.git", :branch => "master", :submodules => true
    pod 'RealmSwift', git: 'https://github.com/realm/realm-cocoa.git', branch: 'master', :submodules => true
    
    target 'VictoryTests' do
        inherit! :search_paths
    end
end
