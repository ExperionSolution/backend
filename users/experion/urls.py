
from django.contrib import admin
from django.urls import path
from django.conf import settings
from django.conf.urls.static import static

from .views import *
###############################################################


urlpatterns = [
    path('admin/', admin.site.urls),
    path('user_edit/<int:pk>/', UserEdit.as_view(), name='user_edit'),
    path('password_edit/<int:pk>/', PasswordEdit.as_view(), name='password_edit'),

]


urlpatterns += static(settings.MEDIA_URL, document_root = settings.MEDIA_ROOT)