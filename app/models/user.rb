# frozen_string_literal: true

# User, handled by devine
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :receipts, dependent: :destroy

  has_many :projects

  after_commit :send_admin_mail, on: :create
  after_commit :create_default_project, on: :create

  enum role: {
    user: 0,
    admin: 99
  }

  # This code is adviced but keeps making my user admin when loggin in.
  # DANGEROUS I think so disabled.
  # Original advice:
  # https://github.com/plataformatec/devise/wiki/How-To:-Add-an-Admin-Role#option-3-using-active-record-enum
  # after_initialize :set_default_role, if: :new_record?
  # def set_default_role
  #   self.role ||= :user
  # end

  # Has any receipt at all
  def hasReceipts
    Current.user.receipts.all.any?
  end

  # Has uploaded a receipt but we are not ready with processing
  def hasReceiptsButNoneProcessedYet
    hasReceipts && !hasProcessedReceipts
  end

  # At least one is processed
  def hasProcessedReceipts
    Current.user.receipts.processed.any?
  end


  def send_admin_mail
    AdminMailer.registration_email.deliver_now
  end

  def create_default_project
    project = self.projects.new
    project.name = 'My project'
    project.save!
  end
end
