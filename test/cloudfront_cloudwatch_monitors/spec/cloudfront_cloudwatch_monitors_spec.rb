require 'spec_helper'

describe cloudwatch_alarm("www.example.com-#{ENV['distribution_id']}-5xxErrorRate") do
  it { should exist }
  it { should belong_to_metric('5xxErrorRate').namespace('AWS/CloudFront') }
end

describe cloudwatch_alarm("www.example.com-#{ENV['distribution_id']}-4xxErrorRate") do
  it { should exist }
  it { should belong_to_metric('4xxErrorRate').namespace('AWS/CloudFront') }
end
