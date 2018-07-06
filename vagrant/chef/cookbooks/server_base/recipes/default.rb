# frozen_string_literal: true

# Cookbook:: server_base
# Recipe:: default
#
# The MIT License (MIT)
#
# Copyright:: 2018, The Authors
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

include_recipe 'os-hardening'
include_recipe 'apt'
include_recipe 'system'
include_recipe 'system::upgrade_packages'
include_recipe 'build-essential'
include_recipe 'vim'
include_recipe 'system::install_packages'

{
  '/etc/skel': 'root',
  '/home/vagrant': 'vagrant',
  '/root': 'root'
}.each do |path, user|
  %w[.bashrc .bash_aliases].each do |file|
    template "#{path}/#{file}" do
      source "#{file}.erb"
      owner user
      group user
    end
  end
end

group 'staff' do
  members 'vagrant'
end
