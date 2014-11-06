require 'spec_helper'

describe 'apticron::define', :type => :define do
  ['Debian'].each do |osfamily|
    let(:facts) {{
      :osfamily => osfamily,
    }}
    let(:pre_condition) { 'include apticron' }
    let(:title) { 'apticron.conf' }

    context "on #{osfamily}" do
      context 'when source file' do
        let(:params) {{
          :config_file_source => 'puppet:///modules/apticron/wheezy/etc/apticron/apticron.conf',
        }}

        it do
          is_expected.to contain_file('define_apticron.conf').with({
            'ensure'  => 'present',
            'source'  => 'puppet:///modules/apticron/wheezy/etc/apticron/apticron.conf',
            'require' => 'Package[apticron]',
          })
        end
      end

      context 'when content string' do
        let(:params) {{
          :config_file_string => '# THIS FILE IS MANAGED BY PUPPET',
        }}

        it do
          is_expected.to contain_file('define_apticron.conf').with({
            'ensure'  => 'present',
            'content' => /THIS FILE IS MANAGED BY PUPPET/,
            'require' => 'Package[apticron]',
          })
        end
      end

      context 'when content template' do
        let(:params) {{
          :config_file_template => 'apticron/wheezy/etc/apticron/apticron.conf.erb',
        }}

        it do
          is_expected.to contain_file('define_apticron.conf').with({
            'ensure'  => 'present',
            'content' => /THIS FILE IS MANAGED BY PUPPET/,
            'require' => 'Package[apticron]',
          })
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
          is_expected.to contain_file('define_apticron.conf').with({
            'ensure'  => 'present',
            'content' => /THIS FILE IS MANAGED BY PUPPET/,
            'require' => 'Package[apticron]',
          })
        end
      end
    end
  end
end
