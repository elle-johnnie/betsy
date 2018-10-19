require "test_helper"

describe UsersController do
  let(:user) { users :one }

  it "gets new" do
    get new_user_url
    value(response).must_be :success?
  end

  it "creates user" do
    user_hash= {
      user: {
      email: 'user3@gmail.com',
      uid: 2,
      username: 'newuser'
      }
    }
    expect {
      post users_path, params: user_hash
    }.must_change "User.count", 1

    must_redirect_to root_path
  end

  it "shows user" do
    get user_url(user)
    value(response).must_be :success?
  end
end
