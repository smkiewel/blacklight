# frozen_string_literal: true

describe SolrDocument do

  before(:each) do

    @solrdoc = SolrDocument.new :id => '00282214', :format => ['Book'], :title_display => 'some-title'

  end

  describe "new" do
    it "takes a Hash as the argument" do
      expect { SolrDocument.new(:id => 1) }.not_to raise_error
    end
  end

  describe "access methods" do

    it "has the right value for title_display" do
      expect(@solrdoc[:title_display]).not_to be_nil
    end

    it "has the right value for format" do
      expect(@solrdoc[:format][0]).to eq 'Book'
    end

    it "provides the item's solr id" do
      expect(@solrdoc.id).to eq '00282214'
    end
  end

  describe '.attribute' do
    subject(:title) { document.title }
    let(:doc_class) do
      Class.new(SolrDocument) do
        attribute :title, Blacklight::Types::String, 'title_tesim'
        attribute :author, Blacklight::Types::Array, 'author_tesim'
        attribute :date, Blacklight::Types::Date, 'date_dtsi'

      end
    end
    let(:document) do
      doc_class.new(id: '123',
                    title_tesim: ['Good Omens'],
                    author_tesim: ['Neil Gaiman', 'Terry Pratchett'],
                    date_dtsi: '1990-01-01T00:00:00Z')
    end
    it "casts the attributes" do
      expect(document.title).to eq 'Good Omens'
      expect(document.author).to eq ['Neil Gaiman', 'Terry Pratchett']
      expect(document.date).to eq Date.new(1990)
    end
  end
end
