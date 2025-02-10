Found 1 test(s).
Creating test database for alias 'default'...
System check identified no issues (0 silenced).
E
======================================================================
ERROR: test_login (myapp.tests.MySeleniumTests.test_login)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/home/isard/DJejemplo/myapp/tests.py", line 104, in test_login
    permissions_select = WebDriverWait(self.selenium, 10).until(
                         ^^^^^^^^^^^^^
NameError: name 'WebDriverWait' is not defined

----------------------------------------------------------------------
Ran 1 test in 13.508s

FAILED (errors=1)
Destroying test database for alias 'default'...

