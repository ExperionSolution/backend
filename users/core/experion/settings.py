from pathlib import Path
import dj_database_url
import os
####################################################################
###

BASE_DIR = Path(__file__).resolve().parent.parent


SECRET_KEY = 'django-insecure--r&((h)^lybqq72yd9tcb&&xcnfbp*y2gg=kl(!w5o(ca088u='



#---------------APPS-------------------------------------#
INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',

    'rest_framework',

    'DB',
]


#---------------MIDDLEWARE-------------------------------------#
MIDDLEWARE = [
    'django.middleware.security.SecurityMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',

    'whitenoise.middleware.WhiteNoiseMiddleware',
    'crum.CurrentRequestUserMiddleware',
]

X_FRAME_OPTIONS = "SAMEORIGIN"

ROOT_URLCONF = 'experion.urls'

TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [
                BASE_DIR / 'templates'
        ],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
            ],
        },
    },
]

WSGI_APPLICATION = 'experion.wsgi.application'


REST_FRAMEWORK = {
    'DEFAULT_PAGINATION_CLASS': 'rest_framework.pagination.PageNumberPagination',
    'PAGE_SIZE': 10
}

#--------------- Passweord Validation-----------------------#
AUTH_PASSWORD_VALIDATORS = [
    {
        'NAME': 'django.contrib.auth.password_validation.UserAttributeSimilarityValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.MinimumLengthValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.CommonPasswordValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.NumericPasswordValidator',
    },
]



#---------------------- Regional Congig------------------------#
LANGUAGE_CODE = 'es-la'

TIME_ZONE = 'UTC'

USE_I18N = True

USE_TZ = True


#-----------------Static Files--------------------------------#

STATIC_URL = 'static/'
MEDIA_URL = 'media-user/'


STATICFILES_STORAGE = 'whitenoise.storage.CompressedManifestStaticFilesStorage'
DEFAULT_AUTO_FIELD = 'django.db.models.BigAutoField'

STATICFILES_DIRS = (os.path.join(BASE_DIR, 'static'),)
STATIC_ROOT = os.path.join(BASE_DIR, 'static_root')

MEDIA_ROOT = os.path.join(BASE_DIR, 'media')


#--------------------Users----------------------------------------#

SESSION_SERIALIZER = 'django.contrib.sessions.serializers.PickleSerializer'
SESSION_ENGINE = 'django.contrib.sessions.backends.db'
AUTH_USER_MODEL = 'DB.Users'

LOGIN_REDIRECT_URL = 'index'


#---------------Send Mail-----------------------------------------#
EMAIL_BACKEND="django.core.mail.backends.smtp.EmailBackend"
EMAIL_HOST='smtp.gmail.com'
EMAIL_USE_TLS=True
EMAIL_PORT=587
EMAIL_HOST_USER="experiontest2023@gmail.com"
EMAIL_HOST_PASSWORD="lgksvypjjmelvuys"


#---------------BD Desarrollo-----------------------------------------#

DEBUG = True


db_from_env = dj_database_url.config(conn_max_age=500)



# ALLOWED_HOSTS = ['localhost']

# DATABASES = {
#     'default': {
#         'ENGINE': 'django.db.backends.postgresql',
#         'NAME': 'postgres',
#         'USER': 'user',
#         'PASSWORD': 'admin',
#         'HOST': 'local_pgdb',
#         'PORT': 5432,
#     }
# }


ALLOWED_HOSTS = []

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': 'Experion-test',
        'USER': 'postgres',
        'PASSWORD': '210703920014Leo',
        'HOST': 'localhost',
        'PORT': 5432,
    }
}
