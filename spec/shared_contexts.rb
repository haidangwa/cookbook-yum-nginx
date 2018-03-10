# frozen_string_literal: true

shared_context 'rpmquery' do
  before(:each) do
    stub_command("rpm -qi gpg-pubkey-7bd9bf62-* | grep 'not installed'")
      .and_return(true)
  end
end
