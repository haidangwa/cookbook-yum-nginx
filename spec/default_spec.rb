# frozen_string_literal: true

require 'spec_helper'

describe 'new-yum-nginx' do
  describe 'when on redhat 7.4' do
    describe 'by default' do
      let(:chef_run) do
        ChefSpec::SoloRunner.new.converge(described_recipe)
      end

      it 'downloaded gpg key file and notify resource to import key' do
        resource = chef_run.cookbook_file('nginx_signing.key')
        expect(chef_run).to create_cookbook_file('nginx_signing.key')
          .with(path: "#{Dir.tmpdir}/nginx_signing.key")
        expect(resource).to notify('execute[import gpgkey]').to(:run)
                                                            .immediately
      end

      it 'imported gpg key' do
        expect(chef_run.execute('import gpgkey')).to do_nothing
      end

      it 'should create the nginx-stable repo with default attribs' do
        expect(chef_run).to create_yum_repository('nginx-stable').with(
          description: 'nginx stable repo',
          baseurl: 'https://nginx.org/packages/redhat/7/$basearch/',
          gpgcheck: true,
          sslverify: true,
          enabled: true
        )
      end

      it 'should not create the nginx-stable-source repo' do
        expect(chef_run).to_not create_yum_repository('nginx-stable-source')
      end

      it 'should not create the nginx-mainline repo' do
        expect(chef_run).to_not create_yum_repository('nginx-mainline')
      end

      it 'should not create the nginx-mainline-source repo' do
        expect(chef_run).to_not create_yum_repository('nginx-mainline-source')
      end
    end

    describe 'when nginx-stable is not managed and non-stable repos managed' do
      let(:chef_run) do
        ChefSpec::SoloRunner.new do |node|
          node.normal['yum-nginx']['repos']['nginx-stable']['managed'] = false
          node.normal['yum-nginx']['repos']['nginx-stable-source']['managed'] = true
          node.normal['yum-nginx']['repos']['nginx-mainline']['managed'] = true
          node.normal['yum-nginx']['repos']['nginx-mainline-source']['managed'] = true
        end.converge(described_recipe)
      end

      it 'should not create the nginx-stable repo' do
        expect(chef_run).to_not create_yum_repository('nginx-stable')
      end

      it 'should create the nginx-stable-source repo with default attribs' do
        expect(chef_run).to create_yum_repository('nginx-stable-source').with(
          description: 'nginx stable source repo',
          baseurl: 'https://nginx.org/packages/redhat/7/SRPMS/',
          gpgcheck: true,
          sslverify: true,
          enabled: true
        )
      end

      it 'should create the nginx-mainline repo with default attribs' do
        expect(chef_run).to create_yum_repository('nginx-mainline').with(
          description: 'nginx mainline repo',
          baseurl: 'https://nginx.org/packages/mainline/redhat/7/$basearch/',
          gpgcheck: true,
          sslverify: true,
          enabled: true
        )
      end

      it 'should create the nginx-mainline-source repo default attribs' do
        expect(chef_run).to create_yum_repository('nginx-mainline-source').with(
          description: 'nginx mainline source repo',
          baseurl: 'https://nginx.org/packages/mainline/redhat/7/SRPMS/',
          gpgcheck: true,
          sslverify: true,
          enabled: true
        )
      end
    end

    describe 'when adding a custom nginx repo' do
      let(:chef_run) do
        ChefSpec::SoloRunner.new do |node|
          node.normal['yum-nginx']['repos']['nginx-new']['managed'] = true
          node.normal['yum-nginx']['repos']['nginx-new']['repositoryid'] = 'nginx-new'
          node.normal['yum-nginx']['repos']['nginx-new']['description'] = 'nginx New'
          node.normal['yum-nginx']['repos']['nginx-new']['baseurl'] = 'http://path.to.nginx'
          node.normal['yum-nginx']['repos']['nginx-new']['gpgcheck'] = true
          node.normal['yum-nginx']['repos']['nginx-new']['gpgkey'] = 'file://path/to/gpg/key'
          node.normal['yum-nginx']['repos']['nginx-new']['sslverify'] = true
          node.normal['yum-nginx']['repos']['nginx-new']['enabled'] = true
        end.converge(described_recipe)
      end

      it 'should create the nginx-new repo' do
        expect(chef_run).to create_yum_repository('nginx-new').with(
          repositoryid: 'nginx-new',
          description: 'nginx New',
          baseurl: 'http://path.to.nginx',
          gpgcheck: true,
          gpgkey: 'file://path/to/gpg/key',
          sslverify: true,
          enabled: true
        )
      end
    end
  end

  ['6.9', '7.4'].each do |version|
    describe "when on redhat #{version}" do
      let(:chef_run) do
        ChefSpec::SoloRunner.new(platform: 'redhat', version: version).converge(described_recipe)
      end

      it 'should not raise an error' do
        expect { chef_run }.to_not raise_error
      end
    end
  end

  describe 'when on an unsupported platform' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new do |node|
        node.normal['yum-nginx']['rhel']['supported-versions']['7'] = false
      end.converge(described_recipe)
    end

    it 'should raise an error' do
      expect { chef_run }.to raise_error('rhel/redhat/7.4 is not supported by the default recipe')
    end
  end
end
