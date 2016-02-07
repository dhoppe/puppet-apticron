require 'spec_helper'

describe 'apticron', :type => :class do
  ['Debian'].each do |osfamily|
    let(:facts) {{
      :osfamily => osfamily,
    }}

    it { is_expected.to compile.with_all_deps }
    it { is_expected.to contain_anchor('apticron::begin') }
    it { is_expected.to contain_class('apticron::params') }
    it { is_expected.to contain_class('apticron::install') }
    it { is_expected.to contain_class('apticron::config') }
    it { is_expected.to contain_anchor('apticron::end') }

    context "on #{osfamily}" do
      describe 'apticron::install' do
        context 'defaults' do
          it do
            is_expected.to contain_package('apticron').with(
              'ensure' => 'present',
            )
            is_expected.to contain_package('apt-listchanges').with(
              'ensure' => 'present',
            )
          end
        end

        context 'when package latest' do
          let(:params) {{
            :package_ensure => 'latest',
          }}

          it do
            is_expected.to contain_package('apticron').with(
              'ensure' => 'latest',
            )
            is_expected.to contain_package('apt-listchanges').with(
              'ensure' => 'latest',
            )
          end
        end

        context 'when package absent' do
          let(:params) {{
            :package_ensure => 'absent',
          }}

          it do
            is_expected.to contain_package('apticron').with(
              'ensure' => 'absent',
            )
            is_expected.to contain_package('apt-listchanges').with(
              'ensure' => 'absent',
            )
          end
          it do
            is_expected.to contain_file('apticron.conf').with(
              'ensure'  => 'present',
              'require' => 'Package[apticron]',
            )
          end
        end

        context 'when package purged' do
          let(:params) {{
            :package_ensure => 'purged',
          }}

          it do
            is_expected.to contain_package('apticron').with(
              'ensure' => 'purged',
            )
            is_expected.to contain_package('apt-listchanges').with(
              'ensure' => 'purged',
            )
          end
          it do
            is_expected.to contain_file('apticron.conf').with(
              'ensure'  => 'absent',
              'require' => 'Package[apticron]',
            )
          end
        end
      end

      describe 'apticron::config' do
        context 'defaults' do
          it do
            is_expected.to contain_file('apticron.conf').with(
              'ensure'  => 'present',
              'require' => 'Package[apticron]',
            )
          end
        end

        context 'when source dir' do
          let(:params) {{
            :config_dir_source => 'puppet:///modules/apticron/wheezy/etc/apticron',
          }}

          it do
            is_expected.to contain_file('apticron.dir').with(
              'ensure'  => 'directory',
              'force'   => false,
              'purge'   => false,
              'recurse' => true,
              'source'  => 'puppet:///modules/apticron/wheezy/etc/apticron',
              'require' => 'Package[apticron]',
            )
          end
        end

        context 'when source dir purged' do
          let(:params) {{
            :config_dir_purge  => true,
            :config_dir_source => 'puppet:///modules/apticron/wheezy/etc/apticron',
          }}

          it do
            is_expected.to contain_file('apticron.dir').with(
              'ensure'  => 'directory',
              'force'   => true,
              'purge'   => true,
              'recurse' => true,
              'source'  => 'puppet:///modules/apticron/wheezy/etc/apticron',
              'require' => 'Package[apticron]',
            )
          end
        end

        context 'when source file' do
          let(:params) {{
            :config_file_source => 'puppet:///modules/apticron/wheezy/etc/apticron/apticron.conf',
          }}

          it do
            is_expected.to contain_file('apticron.conf').with(
              'ensure'  => 'present',
              'source'  => 'puppet:///modules/apticron/wheezy/etc/apticron/apticron.conf',
              'require' => 'Package[apticron]',
            )
          end
        end

        context 'when content string' do
          let(:params) {{
            :config_file_string => '# THIS FILE IS MANAGED BY PUPPET',
          }}

          it do
            is_expected.to contain_file('apticron.conf').with(
              'ensure'  => 'present',
              'content' => /THIS FILE IS MANAGED BY PUPPET/,
              'require' => 'Package[apticron]',
            )
          end
        end

        context 'when content template' do
          let(:params) {{
            :config_file_template => 'apticron/wheezy/etc/apticron/apticron.conf.erb',
          }}

          it do
            is_expected.to contain_file('apticron.conf').with(
              'ensure'  => 'present',
              'content' => /THIS FILE IS MANAGED BY PUPPET/,
              'require' => 'Package[apticron]',
            )
          end
        end

        context 'when content template (custom)' do
          let(:params) {{
            :config_file_template     => 'apticron/wheezy/etc/apticron/apticron.conf.erb',
            :config_file_options_hash => {
              'key' => 'value',
            },
          }}

          it do
            is_expected.to contain_file('apticron.conf').with(
              'ensure'  => 'present',
              'content' => /THIS FILE IS MANAGED BY PUPPET/,
              'require' => 'Package[apticron]',
            )
          end
        end
      end
    end
  end
end
