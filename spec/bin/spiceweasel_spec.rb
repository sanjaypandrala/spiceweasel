# Cover-all spec to prevent regressions during refactor
describe 'The Spiceweasel binary' do
  before(:each) do
    @expected_output = <<-OUTPUT
knife cookbook upload apache2
knife cookbook upload apt
knife cookbook upload mysql
knife environment from file development.rb
knife environment from file qa.rb
knife environment from file production.rb
knife role from file base.rb
knife role from file iisserver.rb
knife role from file monitoring.rb
knife role from file webserver.rb
knife data bag create users
knife data bag from file users alice.json
knife data bag from file users bob.json
knife data bag from file users chuck.json
knife data bag create data
knife data bag create passwords
knife data bag from file passwords mysql.json --secret-file secret_key
knife data bag from file passwords rabbitmq.json --secret-file secret_key
knife bootstrap serverA -i ~/.ssh/mray.pem -x user --sudo -d ubuntu10.04-gems -r 'role[base]'
knife bootstrap serverB -i ~/.ssh/mray.pem -x user --sudo -d ubuntu10.04-gems -E production -r 'role[base]'
knife bootstrap serverC -i ~/.ssh/mray.pem -x user --sudo -d ubuntu10.04-gems -E production -r 'role[base]'
knife ec2 server create -S mray -i ~/.ssh/mray.pem -x ubuntu -G default -I ami-7000f019 -f m1.small -r 'role[webserver],recipe[mysql::client]'
knife ec2 server create -S mray -i ~/.ssh/mray.pem -x ubuntu -G default -I ami-7000f019 -f m1.small -r 'role[webserver],recipe[mysql::client]'
knife ec2 server create -S mray -i ~/.ssh/mray.pem -x ubuntu -G default -I ami-7000f019 -f m1.small -r 'role[webserver],recipe[mysql::client]'
knife ec2 server create -S mray -i ~/.ssh/mray.pem -x ubuntu -G default -I ami-7000f019 -f m1.small -r 'role[webserver],recipe[mysql::client]'
knife rackspace server create --image 49 --flavor 2 -r 'recipe[mysql],role[monitoring]'
knife rackspace server create --image 49 --flavor 2 -r 'recipe[mysql],role[monitoring]'
knife rackspace server create --image 49 --flavor 2 -r 'recipe[mysql],role[monitoring]'
knife bootstrap windows winrm winboxA -x Administrator -P 'super_secret_password' -r 'role[base],role[iisserver]'
knife bootstrap windows ssh winboxB -x Administrator -P 'super_secret_password' -r 'role[base],role[iisserver]'
knife bootstrap windows ssh winboxC -x Administrator -P 'super_secret_password' -r 'role[base],role[iisserver]'
    OUTPUT

    @spiceweasel_binary = File.join(File.dirname(__FILE__), *%w[.. .. bin spiceweasel])
  end

  it "maintains consistent output from the example config" do
    `#{@spiceweasel_binary} --novalidation --dryrun example.yml`.should == @expected_output
  end
end
