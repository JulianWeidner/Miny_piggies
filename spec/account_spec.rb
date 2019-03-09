require "./lib/classes/account"

RSpec.describe Account do
  describe "#email" do
    it "returns @email value" do
      e_parm = "test@testmail.com"
      p_parm = "pass123"
      user = Account.new(e_parm, p_parm)
      user_email = user.email
      expect(user_email).to eql(e_parm)
    end
  end
end