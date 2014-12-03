import unittest
from api import app
from utils import redis_get_domains, redis_insert_domain, redis_delete_domain

class UtilTest(unittest.TestCase):
    def setUp(self):
        pass
    def test_insert_domain_publishes_to_channel_domains(self):
        pass

if __name__ == '__main__':
    unittest.main()
