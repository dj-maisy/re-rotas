module Rotas::Authorisation
  AUTHORISED_DOMAINS = [
    "digital.cabinet-office.gov.uk",
    "dsit.gov.uk",
    "auth.user",
  ].freeze

  def self.email_authorised?(email)
    email.end_with?(*AUTHORISED_DOMAINS)
  end

  def self.is_admin?(email)
    admins = %w[
      david.mays@digital.cabinet-office.gov.uk
      jason.birchall@digital.cabinet-office.gov.uk
      stephen.grier@digital.cabinet-office.gov.uk
      disable@auth.user
    ]

    admins.include?(email.downcase)
  end
end
