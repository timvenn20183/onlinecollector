def encrypt(value)
  secret = Digest::SHA1.hexdigest('salt')
  code = ActiveSupport::MessageEncryptor.new(secret)
  return code.encrypt_and_sign(value.to_s)
end

def decrypt(value)
    secret = Digest::SHA1.hexdigest('salt')
    code = ActiveSupport::MessageEncryptor.new(secret)
    return code.decrypt_and_verify(value.to_s)
end

