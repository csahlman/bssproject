def valid_signin(user)
  visit sign_in_path
  fill_in "Email",    with: user.email
  fill_in "Password", with: user.password
  click_button "Login"
  cookies[:remember_token] = user.remember_token
end

def test_sign_in(user)
  controller.sign_in(user)
end

def test_current_user(user)
  current_user=(user)
end

