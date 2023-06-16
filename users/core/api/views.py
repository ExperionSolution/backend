import re

from rest_framework.generics import ListAPIView, CreateAPIView
from rest_framework.views import APIView

from rest_framework import status
from rest_framework.response import Response


from django.utils.http import urlsafe_base64_encode, urlsafe_base64_decode
from django.utils.encoding import force_bytes, force_str
from django.utils.translation import gettext_lazy as _

from django.contrib.sites.shortcuts import get_current_site
from django.contrib.auth.tokens import default_token_generator

from django.urls import reverse

from django.template.loader import render_to_string

from django.core.mail import send_mail

from .serializers import *
from DB.models import *

####################################################################################


class UsersListAPIView(ListAPIView):
    queryset = Users.objects.all()
    serializer_class = UsersListSerializers

class UserRegisterApiView(CreateAPIView):
    serializer_class = UserRegisterSerializers

    def password_complex(self, password):
        if len(password) < 8:
            return False
        if not re.search(r"[a-z]",password) or not re.search(r"[A-Z]",password):
            return False
        if not re.search(r"\d",password):
            return False
        if not re.search(r"[!@$%&*]",password):
            return False
        return True

    def perform_create(self, serializer):
        user = serializer.save()
        user.username = user.email
        user.first_name = user.first_name.capitalize()
        user.last_name = user.last_name.capitalize()
        user.is_active = False
        user.save()

    def post(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)

        password = serializer.validated_data.get('password')
        if not self.password_complex(password):
            return Response({'error': 'Password does not meet requirements', 'length': 'Minimum length of 8 characters', 'content': 'must contain at least one letter, one number and one symbol ! @ $ % & * '}, status=status.HTTP_400_BAD_REQUEST)

        self.perform_create(serializer)
        usuario = serializer.instance
        self.enviar_correo_activacion(usuario, request)

        headers = self.get_success_headers(serializer.data)
        return Response(serializer.data, status=status.HTTP_201_CREATED, headers=headers)


    def enviar_correo_activacion(self, usuario, request):
        current_site = get_current_site(request)
        uid = urlsafe_base64_encode(force_bytes(usuario.id))
        activate_url = reverse('user_activate', kwargs={
                               'uidb64': uid, 'token': default_token_generator.make_token(usuario)})
        activation_link = f"http://{current_site.domain}{activate_url}"
        subject = 'Activación de cuenta'
        message = render_to_string('activate_account.html', {
            'usuario': usuario,
            'activation_link': activation_link,
            'domain': current_site.domain,
            'uid': urlsafe_base64_encode(force_bytes(usuario.id)),
            'token': default_token_generator.make_token(usuario),
        })
        send_mail(subject, message, settings.EMAIL_HOST_USER, [usuario.email])

class UserActivateApiView(APIView):
    def get(self, request, uidb64, token, *args, **kwargs):
        try:
            uid = force_str(urlsafe_base64_decode(uidb64))
            usuario = Users.objects.get(pk=uid)
        except (TypeError, ValueError, OverflowError, Users.DoesNotExist):
            usuario = None

        if usuario is not None and default_token_generator.check_token(usuario, token):
            usuario.is_active = True
            usuario.save()
            return Response(status=status.HTTP_200_OK)
        else:
            return Response(status=status.HTTP_500_INTERNAL_SERVER_ERROR)


class UserUpdateApiView(APIView):
    serializer_class = UsersUpdateSerializers

    def get(self,request,pk):
        try:
            user = Users.objects.get(pk=pk)
            serializer = UsersListSerializers(user)
            return Response(serializer.data, status=status.HTTP_200_OK)
        except Users.DoesNotExist:
            return Response({'error': 'User not found'}, status=status.HTTP_404_NOT_FOUND,)

    def put(self, request, pk):
        try:
            user = Users.objects.get(pk=pk)
            serializer = UsersUpdateSerializers(user, data=request.data)
            if serializer.is_valid():
                user = serializer.save()
                user.country = user.country.capitalize()
                user.city = user.city.capitalize()
                user.address = user.address.capitalize()
                user.save()
                return Response(serializer.data, status=status.HTTP_200_OK)
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
        except Users.DoesNotExist:
            return Response({'error': 'User not found'}, status=status.HTTP_404_NOT_FOUND,)


