require 'spec_helper_acceptance'

case fact('osfamily')
when 'Debian'
  package_name     = 'apticron'
  package_list     = 'apt-listchanges'
  config_file_path = '/etc/apticron/apticron.conf'
end

describe 'apticron', :if => SUPPORTED_PLATFORMS.include?(fact('osfamily')) do
  it 'is_expected.to work with no errors' do
    pp = <<-EOS
      class { 'apticron': }
    EOS

    apply_manifest(pp, :catch_failures => true)
    apply_manifest(pp, :catch_changes => true)
  end

  describe 'apticron::install' do
    context 'defaults' do
      it 'is_expected.to work with no errors' do
        pp = <<-EOS
          class { 'apticron': }
        EOS

        apply_manifest(pp, :catch_failures => true)
      end

      describe package(package_name) do
        it { is_expected.to be_installed }
      end
      describe package(package_list) do
        it { is_expected.to be_installed }
      end
    end

    context 'when package latest' do
      it 'is_expected.to work with no errors' do
        pp = <<-EOS
          class { 'apticron':
            package_ensure => 'latest',
          }
        EOS

        apply_manifest(pp, :catch_failures => true)
      end

      describe package(package_name) do
        it { is_expected.to be_installed }
      end
      describe package(package_list) do
        it { is_expected.to be_installed }
      end
    end

    context 'when package absent' do
      it 'is_expected.to work with no errors' do
        pp = <<-EOS
          class { 'apticron':
            package_ensure => 'absent',
          }
        EOS

        apply_manifest(pp, :catch_failures => true)
      end

      describe package(package_name) do
        it { is_expected.not_to be_installed }
      end
      describe package(package_list) do
        it { is_expected.not_to be_installed }
      end
      describe file(config_file_path) do
        it { is_expected.to be_file }
      end
    end

    context 'when package purged' do
      it 'is_expected.to work with no errors' do
        pp = <<-EOS
          class { 'apticron':
            package_ensure => 'purged',
          }
        EOS

        apply_manifest(pp, :catch_failures => true)
      end

      describe package(package_name) do
        it { is_expected.not_to be_installed }
      end
      describe package(package_list) do
        it { is_expected.not_to be_installed }
      end
      describe file(config_file_path) do
        it { is_expected.not_to be_file }
      end
    end
  end

  describe 'apticron::config' do
    context 'defaults' do
      it 'is_expected.to work with no errors' do
        pp = <<-EOS
          class { 'apticron': }
        EOS

        apply_manifest(pp, :catch_failures => true)
      end

      describe file(config_file_path) do
        it { is_expected.to be_file }
      end
    end

    context 'when content template' do
      it 'is_expected.to work with no errors' do
        pp = <<-EOS
          class { 'apticron':
            config_file_template => "apticron/#{fact('lsbdistcodename')}/#{config_file_path}.erb",
          }
        EOS

        apply_manifest(pp, :catch_failures => true)
      end

      describe file(config_file_path) do
        it { is_expected.to be_file }
        it { is_expected.to contain 'THIS FILE IS MANAGED BY PUPPET' }
      end
    end

    context 'when hash of files' do
      it 'is_expected.to work with no errors' do
        pp = <<-EOS
          class { 'apticron':
            config_file_hash => {
              'apticron' => {
                config_file_path     => '/etc/cron.d/apticron',
                config_file_template => 'apticron/common/etc/cron.d/apticron.erb',
              },
              'listchanges.conf' => {
                config_file_path     => '/etc/apt/listchanges.conf',
                config_file_template => 'apticron/common/etc/apt/listchanges.conf.erb',
                config_file_require  => 'Package[apt-listchanges]',
              },
            },
          }
        EOS

        apply_manifest(pp, :catch_failures => true)
      end

      describe file('/etc/cron.d/apticron') do
        it { is_expected.to be_file }
        it { is_expected.to contain 'THIS FILE IS MANAGED BY PUPPET' }
      end
      describe file('/etc/apt/listchanges.conf') do
        it { is_expected.to be_file }
        it { is_expected.to contain 'THIS FILE IS MANAGED BY PUPPET' }
      end
    end
  end
end
