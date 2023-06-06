import pytest
from faker import Faker
from DB.models import Users
from experion.views import LoginView


fake = Faker()

@pytest.fixture
def user_creation():
    return Users(
        username=fake.name(),
        first_name=fake.first_name(),
        last_name=fake.last_name(),
        email=fake.free_email(),
        password='Test1234',
    )


@pytest.mark.django_db          #Determina que se cree correctamente el usuario
def test_user_create(user_creation):
    user_creation.save()
    assert user_creation.id == 1



@pytest.mark.django_db          #Determina que si faltan argumentos, falla
def test_user_create_fail():
    with pytest.raises(Exception):
        Users.objects.create_user(
            first_name = 'leonardo',
            password = 'Test1234',
        )

