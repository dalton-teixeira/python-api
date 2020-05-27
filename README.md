# Start up python-api

`cd api`

using python 2


`pip install -r requirements.txt` --user

`python api.py`

python 3

`pip3 install -r requirements.txt` --user

`python3 api.py`


In case port 5000 to be in use by another execution, you can kill the process with:

`fuser 5000/tcp -k`



# Running robots


`python3 -m robot <test-file>.robot`
