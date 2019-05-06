# Make sure the Apt package lists are up to date, so we're downloading versions that exist.
cookbook_file "apt-sources.list" do
  path "/etc/apt/sources.list"
end
execute 'apt_update' do
  command 'apt-get update'
end

# Base configuration recipe in Chef.
package "wget"
package "curl"
package "ntp"
package "python3-pip"

cookbook_file "ntp.conf" do
  path "/etc/ntp.conf"
end
execute 'ntp_restart' do
  command 'service ntp restart'
end

    # My Configuration

app_dir = "/home/ubuntu/project"
# app_dir = "/home/vagrant"

directory app_dir do
  owner 'ubuntu'
  group 'ubuntu'
  mode '0755'
end

execute 'install basc-py4chan' do
    command 'sudo -H pip3 install BASC-py4chan'
    cwd     app_dir
    user    "ubuntu"
end

timezone 'Set the hosts timezone to America/Vancouver' do
  timezone 'America/Vancouver'
end

file '/home/ubuntu/project/script.sh' do
  mode '0755'  
  owner 'vagrant'
end

cron 'ylyl cron' do
  minute '*/5'
  command 'sh -x /home/ubuntu/project/script.sh > /home/ubuntu/project/ylyl.log 2>&1'
end

# */5 * * * * sh /home/ubuntu/project/script.sh > /home/ubuntu/project/ylyl.log 2>&1

# execute 'install pipenv' do
#     command 'sudo -H pip install --user pipenv'
#     cwd     app_dir
#     user    "ubuntu"
# end

