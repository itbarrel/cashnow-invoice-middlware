# frozen_string_literal: true

user = User.find_or_create_by(email: 'admin@cashnow.com')
user.update(password: '12345678')
