###############################################################
# pip install .; npytest -v --capture=no  tests/test_get.py:Test_get.test_001
# pytest -v --capture=no  tests/test_get.py
# pytest -v tests/test_get.py
###############################################################


import getpass

from cloudmesh.common.Shell import Shell
from cloudmesh.common.util import HEADING


def run(command):
    parameter = command.split(" ")
    shell_command = parameter[0]
    args = parameter[1:]
    result = Shell.execute(shell_command, args)
    return str(result)


# noinspection PyMethodMayBeStatic,PyPep8Naming
class Test_get(object):
    """

    """

    def setup(self):
        pass

    def test_001_install(self):
        HEADING()
        r = run("whoami")
        print(r)
        assert getpass.getuser() in r
