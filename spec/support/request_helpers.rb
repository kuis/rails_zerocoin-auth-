module RequestHelpers
  def auth_with_user(user)
    FactoryGirl.create(:api_key, user: user)
  end

  def json
    @json ||= JSON.parse(response.body)
  end

  def expect_ok_status
    expect(response.status).to eq(200)
  end

  def expect_created_status
    expect(response.status).to eq(201)
  end

  def expect_no_content_status
    expect(response.status).to eq(204)
  end

  def expect_error_status
    expect(response.status).to eq(400)
  end

  def expect_unauthorized_status
    expect(response.status).to eq(401)
  end

  def expect_unprocessable_status
    expect(response.status).to eq(422)
  end
end
