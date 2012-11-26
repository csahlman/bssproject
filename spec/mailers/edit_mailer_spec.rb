require "spec_helper"

describe EditMailer do
  describe "idiom_edit_mailer" do
    let(:mail) { EditMailer.idiom_edit_mailer }

    it "renders the headers" do
      mail.subject.should eq("Idiom edit mailer")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
