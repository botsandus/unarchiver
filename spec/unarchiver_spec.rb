require "spec_helper"

RSpec.describe Unarchiver do
  subject(:archive_util) { described_class.new(file) }

  describe "#expand(valid_extensions: nil)" do
    context "if the file is missing" do
      let(:file) { nil }

      it "returns an empty array" do
        expect(archive_util.expand).to eq([])
      end
    end

    context "if the file is not a zip file" do
      let(:file) { file_fixture("a.txt").open }

      it "returns a tempfile from original file" do
        expect(archive_util.expand.first.read).to eq(file.read)
      end
    end

    context "if the file is a zip file" do
      let(:file) { file_fixture("sample.zip").open }

      it "returns the contents of the zip file" do
        filenames = archive_util.expand.map { |f| File.basename(f.path) }

        expect(filenames.size).to eq(3)

        expect(filenames[0]).to match(/\Aa.*\.txt\z/)
        expect(filenames[1]).to match(/\Ab.*\.txt\z/)
        expect(filenames[2]).to match(/\Ac.*\.png\z/)
      end

      context "and a list of valid extensions is provided" do
        it "returns only the files with the valid extensions" do
          filenames = archive_util.expand(valid_extensions: %(txt)).map { |f| File.basename(f.path) }

          expect(filenames.size).to eq(2)

          expect(filenames[0]).to match(/\Aa.*\.txt\z/)
          expect(filenames[1]).to match(/\Ab.*\.txt\z/)
        end
      end
    end
  end
end
