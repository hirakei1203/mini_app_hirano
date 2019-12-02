class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and 
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, 
         :omniauthable
  #  omniauth_providers: %i[facebook], [:google_oauth2]
  has_many :logs
  has_many :comments
  has_many :sns_credentials

  def self.from_omniauth(auth)
    # 1メールアドレス(1userレコード)に複数のsns_credentialがつくことを許容する場合
    user = User.where(email: auth.info.email).first
    sns_credential_record = SnsCredential.where(provider: auth.provider, uid: auth.uid)

    if user.present?
      unless sns_credential_record.present?
        SnsCredential.create(
          user_id: user.id,
          provider: auth.provider,
          uid: auth.uid
        )
      end
    elsif
      user = User.create(
        user_name: auth.info.name,
        id: User.all.last.id + 1,
        email: auth.info.email,
        password: Devise.friendly_token[0, 20],
      )
      SnsCredential.create(
        provider: auth.provider,
        uid: auth.uid,
        user_id: user.id
      )
    end 
  user
  end
    # 予備コード（既存レコードとメールアドレスが被った場合、unique制約によりsave出来ない不具合あり・・・)
    # credential_account = SnsCredential.where(provider: auth.provider, uid: auth.uid).first
    # if credential_account.present?
    #   user_id = credential_account.user_id
    #   user = User.find(user_id)
    # elsif
    #   user_id = User.all.last.id + 1
    #   user = User.create(
    #     id: user_id,
    #     email: auth.info.email,
    #     password: Devise.friendly_token[0, 20],
    #     user_name: auth.info.name
    #   )
    #   new_credential_account = SnsCredential.create(
    #     provider: auth.provider,
    #     uid: auth.uid,
    #     user_id: user_id
    #   ) 
    #   user = User.find(user_id)
    # end

    # where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
    #   user.email = auth.info.email
    #   user.password = Devise.friendly_token[0, 20]
    #   user.user_name = auth.info.name
    # end

 #   end
end
