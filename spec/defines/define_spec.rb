require 'spec_helper'

describe 'apticron::define', type: :define do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      let(:pre_condition) { 'include apticron' }
      let(:title) { 'apticron.conf' }

      context 'when source file' do
        let(:params) do
          {
            config_file_path: '/etc/apticron/apticron.2nd.conf',
            config_file_source: 'puppet:///modules/apticron/wheezy/etc/apticron/apticron.conf'
          }
        end

        it do
          is_expected.to contain_file('define_apticron.conf').with(
            'ensure'  => 'present',
            'source'  => 'puppet:///modules/apticron/wheezy/etc/apticron/apticron.conf',
            'require' => 'Package[apticron]'
          )
        end
      end

      context 'when content string' do
        let(:params) do
          {
            config_file_path: '/etc/apticron/apticron.3rd.conf',
            config_file_string: '# THIS FILE IS MANAGED BY PUPPET'
          }
        end

        it do
          is_expected.to contain_file('define_apticron.conf').with(
            'ensure'  => 'present',
            'content' => %r{THIS FILE IS MANAGED BY PUPPET},
            'require' => 'Package[apticron]'
          )
        end
      end

      context 'when content template' do
        let(:params) do
          {
            config_file_path: '/etc/apticron/apticron.4th.conf',
            config_file_template: 'apticron/wheezy/etc/apticron/apticron.conf.erb'
          }
        end

        it do
          is_expected.to contain_file('define_apticron.conf').with(
            'ensure'  => 'present',
            'content' => %r{THIS FILE IS MANAGED BY PUPPET},
            'require' => 'Package[apticron]'
          )
        end
      end

      context 'when content template (custom)' do
        let(:params) do
          {
            config_file_path: '/etc/apticron/apticron.5th.conf',
            config_file_template: 'apticron/wheezy/etc/apticron/apticron.conf.erb',
            config_file_options_hash: {
              'key' => 'value'
            }
          }
        end

        it do
          is_expected.to contain_file('define_apticron.conf').with(
            'ensure'  => 'present',
            'content' => %r{THIS FILE IS MANAGED BY PUPPET},
            'require' => 'Package[apticron]'
          )
        end
      end
    end
  end
end
