import os
from robot.libraries.BuiltIn import BuiltIn
import re

class MyLib(object):
    def get_test_folder(self):
        suite_path = BuiltIn().get_variable_value("${SUITE_SOURCE}")
        return os.path.sep.join(suite_path.split(os.path.sep)[:-1])