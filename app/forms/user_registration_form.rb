class UserRegistrationForm < ROM::Model::Form

  MAX_PASSWORD_LENGTH_ALLOWED = 50
  EMAIL_REGEXP = /\A[^@\s]+@([^@\s]+\.)+[^@\W]+\z/

  commands users: :create

  input do
    set_model_name 'UserRegistration'

    attribute :email, String
    attribute :name, String
    attribute :password_digest, String
    attribute :password, String
    attribute :password_confirmation, String
    timestamps

    def password=(unencrypted_password)
      super
      self.password_digest = BCrypt::Password.create(unencrypted_password)
    end
  end

  validations do
    relation :users

    validates :email, presence: true, format: { with: EMAIL_REGEXP }, uniqueness: true
    validates :name, presence: true
    validates :password, presence: true, length: { maximum: MAX_PASSWORD_LENGTH_ALLOWED }
    validates :password_confirmation, presence: true
    validate :password_confirmation_match, if: -> (record) { record.password_confirmation.present? }

    # to avoid active model's accessors creation
    def password_confirmation_match
      errors.add(:password_confirmation, :confirmation, attribute: :password) if password != password_confirmation
    end
  end

  def commit!
    users.try { users.create.call(command_input_transformation.call(attributes)) }
  end

  private

  def command_input_transformation
    Transproc::HashTransformations[:accept_keys, [:email, :name, :password_digest, :created_at, :updated_at]]
  end
end
