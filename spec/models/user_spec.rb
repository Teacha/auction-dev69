require "rails_helper"

RSpec.describe User do
  describe "validations" do
    subject { build(:user) }

    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
    it { is_expected.to validate_presence_of(:provider) }
    it { is_expected.to validate_presence_of(:uid) }
    it { is_expected.to validate_uniqueness_of(:uid).scoped_to(:provider) }
  end

  describe "role" do
    it { is_expected.to define_enum_for(:role).with_values(user: 0, admin: 1).validating }

    it "defaults to user" do
      expect(described_class.new.role).to eq("user")
    end
  end

  describe "email normalization" do
    it "strips and downcases email" do
      expect(build(:user, email: "  Seller@Example.COM ").email).to eq("seller@example.com")
    end
  end

  describe ".from_omniauth" do
    let(:auth) do
      OmniAuth::AuthHash.new(provider: "keycloak", uid: "kc-1", info: { email: "a@example.com", name: "Alice" })
    end

    it "creates a new user with role user on first login" do
      expect { described_class.from_omniauth(auth) }.to change(described_class, :count).by(1)
      expect(described_class.last).to have_attributes(email: "a@example.com", name: "Alice", role: "user")
    end

    it "updates the existing user and keeps the role on later logins" do
      user = create(:user, :admin, provider: "keycloak", uid: "kc-1", email: "old@example.com")

      expect { described_class.from_omniauth(auth) }.not_to change(described_class, :count)
      expect(user.reload).to have_attributes(email: "a@example.com", role: "admin")
    end

    it "raises when Keycloak does not provide an email" do
      auth.info.email = nil

      expect { described_class.from_omniauth(auth) }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
