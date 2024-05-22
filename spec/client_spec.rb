# frozen_string_literal: true

RSpec.describe Unstructured::Client do
  let(:server_url) { "https://api.unstructured.io" }
  let(:client) { described_class.new(server_url: server_url, api_key_auth: "1234") }

  describe "#partition document" do
    before do
      stub_request(:post, "#{server_url}/general/v0/general")
        .to_return(
          status: 200,
          body: [
            {
              type: "CompositeElement",
              element_id: "5db5a93436150acc50a8f9187f44f32d",
              text: stub_text,
              metadata: {
                languages: [
                  "eng"
                ],
                page_number: stub_page_number,
                orig_elements: "5db5a93436150acc50a8f9187f44f32d",
                filename: stub_filename,
                filetype: stub_filetype
              }
            }
          ],
          headers: {}
        )
    end
    let(:stub_text) { "Text content" }
    let(:stub_page_number) { 3 }
    let(:stub_element_id) { "5db5a93436150acc50a8f9187f44f32d" }
    let(:stub_filetype) { "application/pdf" }
    let(:stub_filename) { "test.pdf" }

    it "should partition the document" do
      expect(client.partition("spec/fixtures/sample.pdf")).to be_a(Unstructured::ChunkCollection)
    end

    it "should have chunk properties" do
      expect(client.partition("spec/fixtures/sample.pdf").first.text).to eq(stub_text)
      expect(client.partition("spec/fixtures/sample.pdf").first.element_id).to eq(stub_element_id)
      expect(client.partition("spec/fixtures/sample.pdf").first.metadata.page_number).to eq(stub_page_number)
      expect(client.partition("spec/fixtures/sample.pdf").first.metadata.filetype).to eq(stub_filetype)
      expect(client.partition("spec/fixtures/sample.pdf").first.metadata.filename).to eq(stub_filename)
    end

    it "should return a hash when using to_h" do
      expect(client.partition("spec/fixtures/sample.pdf").first.to_h).to be_a(Hash)
    end
  end
end
