namespace 'cloudfront_cloudwatch_monitors' do
  load '../../terraform-module-testing-framework/scripts/tasks.rake'

  task :validate [:prefix] do
    puts TDK::TerraformLogFilter.filter(
      TDK::Command.run('terraform output api_url')
    )[0]
  end
end
