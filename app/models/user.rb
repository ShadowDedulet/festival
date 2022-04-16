class User < ApplicationRecord
  enum role: %i[user admin]
  enum document_type: %i[passport driver_license birth_certificate]
end
