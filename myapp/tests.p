from django.contrib.staticfiles.testing import StaticLiveServerTestCase
from selenium.webdriver.firefox.webdriver import WebDriver
from selenium.webdriver.firefox.options import Options
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from django.contrib.auth.models import User

 
class MySeleniumTests(StaticLiveServerTestCase):
    # carregar una BD de test
    #fixtures = ['testdb.json',]
 
    @classmethod
    def setUpClass(cls):
        super().setUpClass()
        opts = Options()
        cls.selenium = WebDriver(options=opts)
        cls.selenium.implicitly_wait(5)
 
    @classmethod
    def tearDownClass(cls):
        # tanquem browser
        # comentar la propera línia si volem veure el resultat de l'execució al navegador
        cls.selenium.quit()
        super().tearDownClass()
 
    def test_login(self):
        # creem superusuari
        user = User.objects.create_user("isard", "isard@isardvdi.com", "pirineus")
        user.is_superuser = True
        user.is_staff = True
        user.save()
        # anem directament a la pàgina d'accés a l'admin panel
        self.selenium.get('%s%s' % (self.live_server_url, '/admin/login/'))
 
        # comprovem que el títol de la pàgina és el que esperem
        self.assertEqual( self.selenium.title , "Log in | Django site admin" )
 
        # introduïm dades de login i cliquem el botó "Log in" per entrar
        username_input = self.selenium.find_element(By.NAME,"username")
        username_input.send_keys('isard')
        password_input = self.selenium.find_element(By.NAME,"password")
        password_input.send_keys('pirineus')
        self.selenium.find_element(By.XPATH,'//input[@value="Log in"]').click()
 
        # testejem que hem entrat a l'admin panel comprovant el títol de la pàgina
        self.assertEqual( self.selenium.title , "Site administration | Django site admin" )

         # Crear 2 Questions y 2 Choices (con el superusuario)
        # Crear una primera pregunta
        self.selenium.get('%s%s' % (self.live_server_url, '/admin/myapp/question/add/'))
        question_input = self.selenium.find_element(By.NAME, "question_text")
        question_input.send_keys("Pregunta 1")
        self.selenium.find_element(By.XPATH, '//input[@value="Save"]').click()

        # Crear las opciones (Choices) para la primera pregunta
        self.selenium.get('%s%s' % (self.live_server_url, '/admin/myapp/choice/add/'))
        choice_input = self.selenium.find_element(By.NAME, "choice_text")
        choice_input.send_keys("Opción 1.1")
        self.selenium.find_element(By.XPATH, '//input[@value="Save"]').click()
        
        # Agregar otra opción
        self.selenium.get('%s%s' % (self.live_server_url, '/admin/myapp/choice/add/'))
        choice_input = self.selenium.find_element(By.NAME, "choice_text")
        choice_input.send_keys("Opción 1.2")
        self.selenium.find_element(By.XPATH, '//input[@value="Save"]').click()

        # Crear una segunda pregunta
        self.selenium.get('%s%s' % (self.live_server_url, '/admin/myapp/question/add/'))
        question_input = self.selenium.find_element(By.NAME, "question_text")
        question_input.send_keys("Pregunta 2")
        self.selenium.find_element(By.XPATH, '//input[@value="Save"]').click()

        # Crear las opciones (Choices) para la segunda pregunta
        self.selenium.get('%s%s' % (self.live_server_url, '/admin/myapp/choice/add/'))
        choice_input = self.selenium.find_element(By.NAME, "choice_text")
        choice_input.send_keys("Opción 2.1")
        self.selenium.find_element(By.XPATH, '//input[@value="Save"]').click()

        # Agregar otra opción
        self.selenium.get('%s%s' % (self.live_server_url, '/admin/myapp/choice/add/'))
        choice_input = self.selenium.find_element(By.NAME, "choice_text")
        choice_input.send_keys("Opción 2.2")
        self.selenium.find_element(By.XPATH, '//input[@value="Save"]').click()


        # Crear un usuario staff
        self.selenium.get('%s%s' % (self.live_server_url, '/admin/auth/user/add/'))
        username_input = self.selenium.find_element(By.NAME, "username")
        username_input.send_keys('staff_user')
        password_input = self.selenium.find_element(By.NAME, "password1")
        password_input.send_keys('staff_password')
        password_input_confirm = self.selenium.find_element(By.NAME, "password2")
        password_input_confirm.send_keys('staff_password')
        self.selenium.find_element(By.XPATH, '//input[@value="Save"]').click()

        # Hacer que el usuario sea staff
        self.selenium.find_element(By.NAME, "is_staff").click()
        self.selenium.find_element(By.XPATH, '//input[@value="Save"]').click()

        # Asignar permisos de solo lectura para Question y Choice
        self.selenium.get('%s%s' % (self.live_server_url, '/admin/auth/user/'))
        self.selenium.find_element(By.XPATH, '//a[@href="/admin/auth/user/1/change/"]').click()

        # Espera hasta que el campo de permisos sea clickeable
        permissions_select = WebDriverWait(self.selenium, 10).until(
           EC.element_to_be_clickable((By.NAME, "user_permissions"))
        )
        permissions_select.click()

        choice_permission = WebDriverWait(self.selenium, 10).until(
           EC.presence_of_element_located((By.XPATH, '//input[@title="Myapp | choice | Can view choice"]'))
        )
        choice_permission.click()

        self.selenium.find_element(By.XPATH, '//input[@value="Save"]').click()
        # Asignar permisos: view_question y view_choice
       # self.selenium.find_element(By.NAME, "user_permissions").click()
       # self.selenium.find_element(By.XPATH, '//input[@title="Myapp | choice | Can view choice"]').click()
        #self.selenium.find_element(By.XPATH, '//input[@title="Myapp | choice | Can view choice"]').click()
        #self.selenium.find_element(By.XPATH, '//input[@title="user_permissions"]').click()

        #self.selenium.find_element(By.XPATH, '//input[@value="Save"]').click()

        # Loguearse con el usuario staff
        self.selenium.get('%s%s' % (self.live_server_url, '/admin/login/'))
        username_input = self.selenium.find_element(By.NAME, "username")
        username_input.send_keys('staff_user')
        password_input = self.selenium.find_element(By.NAME, "password")
        password_input.send_keys('staff_password')
        self.selenium.find_element(By.XPATH, '//input[@value="Log in"]').click()

        # Comprobar que puede ver las preguntas
        self.selenium.get('%s%s' % (self.live_server_url, '/admin/myapp/question/'))
        page_title = self.selenium.find_element(By.TAG_NAME, "h1").text
        self.assertTrue("question" in page_title.lower())  # Verifica si la palabra "question" está en el título

        # Intentar acceder a una pregunta para editarla y verificar que no puede
        self.selenium.get('%s%s' % (self.live_server_url, '/admin/myapp/question/1/change/'))
        # Comprobamos que aparece un mensaje de error de "Permission denied"
