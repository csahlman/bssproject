# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  password_digest :string(255)
#  about_me        :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  remember_token  :string(255)
#  uid             :integer
#  provider        :string(255)
#  admin           :boolean          default(FALSE)
#  deleted_at      :datetime
#  banned          :boolean          default(FALSE)
#  receive_emails  :boolean
#

class User < ActiveRecord::Base
  has_secure_password

  validates :name, presence: true, length: { within: 2..50 }
  email_regex= /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: email_regex },
    uniqueness: { cases_sensitive: false }
  validates :password, presence: true, confirmation: true, 
    length: { within: 6..50 }, if: :setting_password?
  validates :password_confirmation, presence: true, if: :setting_password?

    
  has_many :votes
  has_many :comments 
  has_many :idioms
  has_many :reports 
    
  has_many :edits

  has_many :sent_messages, class_name: "Message", foreign_key: "sender_id"
  has_many :received_messages, class_name: "Message", foreign_key: "receiver_id"

  has_one :inbox, dependent: :destroy

  before_create :create_remember_token

  after_create :create_inbox

  after_destroy :ensure_an_admin_remains   #make sure you can't delete last user

  default_scope where(deleted_at: nil)

  def setting_password?
    self.password.present? || self.password_confirmation.present?
  end

  def set_user_attributes(user_hash)
    self.name = user_hash[:name]
    self.email = user_hash[:email]
    self.about_me = user_hash[:about_me]
  end

  def self.from_omniauth(auth)
    where(auth.slice('provider', 'uid')).first || create_or_deny_from_omniauth(auth)
    #pulls out the first provider/uid combo that matches a user, or creates a new one
  end

  def self.create_or_deny_from_omniauth(auth)
    if auth["provider"] == "twitter" || "facebook"
      new_user = User.new do |user|
        user.uid = auth["uid"]
        user.provider = auth["provider"]
        user.name = auth["info"]["name"]
      end
      if auth['provider'] == 'facebook'
        new_user.email = auth["info"]["email"]
        if User.find_by_email auth["info"]["email"]
          raise "There is already an account with that email registered"  
        end
      end
    end
    new_user.save(validate: false) #skip validation of password on facebook/twitter login
    new_user #return the actual user and don't keep forgetting to return stuff    
  end

  def soft_delete
    self.name = nil
    self.email = nil
    self.about_me = nil
    self.deleted_at = Time.now
    save(validate: false)
  end


  private 

    def create_inbox
      self.create_inbox!
    end

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end

    def ensure_an_admin_remains
      if User.count.zero?
        raise "Can't delete last user" #an exception in the callback triggers an automatic rollback
        #the exception is thrown to the controller, where we can use a begin/end block to display a flash
      end
    end
end
