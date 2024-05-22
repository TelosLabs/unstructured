# frozen_string_literal: true

RSpec.describe Unstructured do
  it "has a version number" do
    expect(Unstructured::VERSION).not_to be nil
  end

  it "should have a client" do
    client = Unstructured::Client.new(server_url: "http://localhost:8000", api_key_auth: "1234")
    expect(client).to be_a(Unstructured::Client)
  end
end
