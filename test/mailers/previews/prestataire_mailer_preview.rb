# Preview all emails at http://localhost:3000/rails/mailers/prestataire_mailer
class PrestataireMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/prestataire_mailer/new_candidate
  def new_candidate
    PrestataireMailer.new_candidate
  end

end
