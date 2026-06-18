require "English"

class VersionController < ApplicationController
  skip_before_action :maybe_redirect_if_not_signed_in, only: %i[version]
  skip_before_action :maybe_expire_session, only: %i[version]

  def version
    file_path = Rails.root.join("app", "views", "version", "version.txt")

    if File.exist?(file_path)
      render plain: File.read(file_path)
    else
      render plain: "development-version", status: :ok
    end
  end
end
