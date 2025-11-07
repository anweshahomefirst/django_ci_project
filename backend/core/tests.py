# core/tests.py
from django.test import TestCase
from django.urls import reverse


class CoreViewTests(TestCase):
    def test_index_view(self):
        """
        Tests that the index view returns a 200 status code
        and contains the expected content.
        """
        url = reverse('index')
        response = self.client.get(url)

        self.assertEqual(response.status_code, 200)
        self.assertContains(response, "Hello, CI pipeline!")
