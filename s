(djangoEnv) isard@debian:~/DJejemplo$ ./manage.py test
Found 1 test(s).
Creating test database for alias 'default'...
System check identified no issues (0 silenced).
E
======================================================================
ERROR: test_login (myapp.tests.MySeleniumTests.test_login)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/home/isard/DJejemplo/myapp/tests.py", line 115, in test_login
    clickable = self.selenium.find_element(By.XPATH, '//input[@title="Myapp | choice | Can view choice"]')
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/home/isard/DJejemplo/djangoEnv/lib/python3.11/site-packages/selenium/webdriver/remote/webdriver.py", line 888, in find_element
    return self.execute(Command.FIND_ELEMENT, {"using": by, "value": value})["value"]
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/home/isard/DJejemplo/djangoEnv/lib/python3.11/site-packages/selenium/webdriver/remote/webdriver.py", line 429, in execute
    self.error_handler.check_response(response)
  File "/home/isard/DJejemplo/djangoEnv/lib/python3.11/site-packages/selenium/webdriver/remote/errorhandler.py", line 232, in check_response
    raise exception_class(message, screen, stacktrace)
selenium.common.exceptions.NoSuchElementException: Message: Unable to locate element: //input[@title="Myapp | choice | Can view choice"]; For documentation on this error, please visit: https://www.selenium.dev/documentation/webdriver/troubleshooting/errors#no-such-element-exception
Stacktrace:
RemoteError@chrome://remote/content/shared/RemoteError.sys.mjs:8:8
WebDriverError@chrome://remote/content/shared/webdriver/Errors.sys.mjs:193:5
NoSuchElementError@chrome://remote/content/shared/webdriver/Errors.sys.mjs:511:5
dom.find/</<@chrome://remote/content/shared/DOM.sys.mjs:136:16


----------------------------------------------------------------------
Ran 1 test in 16.506s

FAILED (errors=1)
Destroying test database for alias 'default'...
