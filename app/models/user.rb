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
#

class User < ActiveRecord::Base
  attr_accessible :password, :password_confirmation

  has_secure_password

  validates :name, presence: true, length: { within: 2..50 }
  email_regex= /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: email_regex },
    uniqueness: { cases_sensitive: false }
  validates :password, presence: true, length: { within: 6..50 }

    
  has_many :votes
  has_many :comments 
  has_many :idioms 

  has_many :edits

  has_many :sent_messages, class_name: "Message", foreign_key: "sender_id"
  has_many :received_messages, class_name: "Message", foreign_key: "receiver_id"

  before_create :create_remember_token

  after_destroy :ensure_an_admin_remains   #make sure you can't delete last user

  def self.from_omniauth(auth)
    where(auth.slice('provider', 'uid')).first || create_or_deny_from_omniauth(auth)
  end

  def self.create_or_deny_from_omniauth(auth)
    if User.find_by_email auth["info"]["email"]
      raise "There is already an account with that email registered"
    else
      new_user = User.new do |user|
        user.uid = auth["uid"]
        user.provider = auth["provider"]
        user.name = auth["info"]["name"]
        user.email = auth["info"]["email"]
      end
      new_user.save(validate: false) #skip validation of password on facebook login
      new_user #return the actual user and don't keep forgetting to return stuff
    end
  end

  private 
    def create_remember_token
      self.remember_token= SecureRandom.urlsafe_base64
    end

    def ensure_an_admin_remains
      if User.count.zero?
        raise "Can't delete last user" #an exception in the callback triggers an automatic rollback
        #the exception is thrown to the controller, where we can use a begin/end block to display a flash
      end
    end
end
