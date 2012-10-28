# == Schema Information
#
# Table name: users
#
#  id                     :integer(4)      not null, primary key
#  email                  :string(255)     default(""), not null
#  encrypted_password     :string(255)     default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer(4)      default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  type                   :string(255)
#  created_at             :datetime        not null
#  updated_at             :datetime        not null
#  admin_level            :string(255)
#  external_user_id       :string(50)
#  provider               :string(20)
#  username               :string(255)
#  free_member_level      :string(255)
#  affiliate_member_level :string(255)
#  active                 :boolean(1)
#

class Admin < User
  has_one :admin_profile, :dependent => :destroy
  accepts_nested_attributes_for :admin_profile
  attr_accessible :email, :password, :password_confirmation, :remember_me, :admin_profile_attributes, :admin_level

  levels_hsh = { :view => "View-Only Admin", :user => "User Admin", :site => "Site Admin" , :super => "Super Admin" }
  UI_ADMIN_LEVELS = ["View-Only Admin", "User Admin", "Site Admin" ]

  validates :admin_level, :presence => true, :inclusion => levels_hsh.values
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable
  scope :with_profile, includes(:admin_profile)
  self.per_page = 10

  def is_view_only?
    self.admin_level == "View-Only Admin"
  end

  def is_super_admin?
    self.admin_level == "Super Admin"
  end

  def is_site_admin?
    self.admin_level == "Site Admin"
  end

  def is_user_admin?
    self.admin_level == "User Admin"
  end

end

## To create admins from the rake console, use the following;

# view_admin  = Admin.create!(:email => "view_admin@gmail.com", :password=>"hello12345", :admin_level => "View-Only Admin" )
# user_admin  = Admin.create!(:email => "user_admin@gmail.com", :password=>"hello12345", :admin_level => "User Admin" )
# site_admin  = Admin.create!(:email => "site_admin@gmail.com", :password=>"hello12345", :admin_level => "Site Admin" )
# super_admin = Admin.create!(:email => "super_admin@gmail.com", :password=>"hello12345", :admin_level => "Super Admin" )
