require 'rake'
require 'spec/rake/spectask'

task :default => "spec"

desc "Run all specs"
Spec::Rake::SpecTask.new('spec') do |t|
  t.spec_files = FileList['spec/*.rb']
end

desc "Run all specs with RCov"
Spec::Rake::SpecTask.new('spec_with_rcov') do |t|
  t.spec_files = FileList['spec/*.rb']
  t.rcov = true
  t.rcov_opts = ['--include-file', 'lib/rlisp', 
                 '--exclude', 'gems', 
                 '--exclude', 'spec']
end