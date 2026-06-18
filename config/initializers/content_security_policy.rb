# Be sure to restart your server when you modify this file.

Rails.application.config.content_security_policy do |policy|
  policy.default_src :self
  policy.font_src    :self, :data
  policy.img_src     :self, :data
  policy.object_src  :none

  # Allow standard scripts, the static GOV.UK hash, and inline scripts (which modern browsers ignore if a nonce/hash is present)
  policy.script_src  :self,
                     "'sha256-+6WnXIl4mbFTCARd8N3COQmT3bJJmo32N8q8ZSQAIcU='",
                     :unsafe_inline

  policy.style_src   :self, :unsafe_inline
end

# Generate a dynamic nonce for every request
Rails.application.config.content_security_policy_nonce_generator = -> request { SecureRandom.base64(16) }

# Instruct Rails to attach the dynamic nonce to these specific directives
Rails.application.config.content_security_policy_nonce_directives = %w(script-src)
