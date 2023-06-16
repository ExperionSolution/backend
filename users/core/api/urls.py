from django.urls import path
from .views import *


urlpatterns = [
    path('users_list/', UsersListAPIView.as_view(), name='users_list'),
    path('users_register/', UserRegisterApiView.as_view(), name='users_register'),
    path('user_activate/<str:uidb64>/<str:token>/',UserActivateApiView.as_view(), name='user_activate'),
    path('users_update/<int:pk>/', UserUpdateApiView.as_view(), name='users_update'),

]