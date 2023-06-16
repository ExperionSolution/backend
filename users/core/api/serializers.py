from rest_framework import serializers
from DB.models import *

##########################################################################

class UserRegisterSerializers(serializers.ModelSerializer):
    class Meta:
        model = Users
        fields = ['first_name','last_name', 'email','password']

class UsersListSerializers(serializers.ModelSerializer):
    class Meta:
        model = Users
        fields = '__all__'

class UsersUpdateSerializers(serializers.ModelSerializer):
    class Meta:
        model = Users
        fields = [
            'dni',
            'country',
            'city',
            'address',
            'number_address',
            'phone_number',
            'image_user',
        ]