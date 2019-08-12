from django.test import TestCase
from django.contrib.auth import get_user_model

class ModelTests(TestCase):
    def test_create_user_with_email_successfull(self):
        """ Test creating a new user with an email is successfull """
        email = "elo@test.com"
        password = 'TestPass123'
        user = get_user_model().objects.create_user(
            email=email,
            password=password
        )

        self.assertEqual(user.email, email)
        self.assertTrue(user.check_password(password))

    def test_new_user_email_normalized(self):
        """ test email or a new user is normalized """
        email = 'test_model@TEST.com'
        user = get_user_model().objects.create_user(email, 'test123')

        self.assertEqual(user.email, email.lower())

    def test_new_user_invalid_user(self):
        """ Test creating user with no email raises error """
        with self.assertRaises(ValueError):

            email = "123"
            get_user_model().objects.create_user(email, 'test123')

    def test_create_new_superuser(self):
        """Test creating a new superuser"""

        email = "root@test.com"
        password = 'TestPass123'
        user = get_user_model().objects.create_superuser(
            email,
            password
        )

        self.assertTrue(user.is_superuser)
        self.assertTrue(user.is_staff)
