desc 'Run all tests'
task :test do
  $LOAD_PATH.unshift(File.expand_path('test'))
  require 'redgreen' if Gem.available?('redgreen')
  require 'test/unit'
  require './test/test_nytimes_style'
end

desc 'Build annotated source code'
task :docs do
  sh 'rocco lib/nytimes-style.rb && mv lib/nytimes-style.html ./index.html'
end

namespace :gem do

  desc 'Build and install the gem'
  task :install do
    sh "gem build nytimes-style.gemspec"
    sh "sudo gem install #{Dir['*.gem'].join(' ')} --local --no-ri --no-rdoc"
  end

  desc 'Uninstall the jammit gem'
  task :uninstall do
    sh "sudo gem uninstall -x nytimes-style"
  end
  
end
