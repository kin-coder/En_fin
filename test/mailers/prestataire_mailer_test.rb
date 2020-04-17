require 'test_helper'

class PrestataireMailerTest < ActionMailer::TestCase
  test "new_candidate" do
    mail = PrestataireMailer.new_candidate
    assert_equal "New candidate", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
