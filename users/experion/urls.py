
from django.contrib import admin
from django.urls import path
from django.conf import settings
from django.conf.urls.static import static

from .views import *
###############################################################


urlpatterns = [
    path('admin/', admin.site.urls),
    path('login/', LoginView.as_view(), name='login'),
    path('logout/', LogoutView.as_view(next_page='login'), name='logout'),

    path('sesion_group/<int:pk>/', SesionGroupView.as_view(), name='sesion_group'),

    path('', UserCreate.as_view(), name=''),
    path('index/', Index.as_view(), name='index'),
    path('register/', UserCreate.as_view(), name='register'),
    path('user_edit/<int:pk>/', UserEdit.as_view(), name='user_edit'),
    path('password_edit/<int:pk>/', PasswordEdit.as_view(), name='password_edit'),
    path('user_activate/<str:uidb64>/<str:token>/',UserActivate.as_view(), name='user_activate'),

    path('reset_password/', PasswordRecoveryView.as_view(), name='reset_password'),
    path('reset_password_sent/', PasswordRecoveryDone.as_view(),
         name='reset_password_sent'),
    path('reset/<uidb64>/<token>/', PasswordRecoveryConfirm.as_view(),
         name='password_reset_confirm'),
    path('reset_password_complete/', PasswordRecoveryComplete.as_view(),
         name='reset_password_complete'),
]


urlpatterns += static(settings.MEDIA_URL, document_root = settings.MEDIA_ROOT)