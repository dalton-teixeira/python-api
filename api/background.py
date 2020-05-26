import requests
import json
import sys
import time

time.sleep(5)
r = requests.put('http://127.0.0.1:5000', json=json.loads(sys.argv[1]))