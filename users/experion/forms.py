from django import forms
from DB.models import *
##############################################################

class UserEditForm(forms.ModelForm):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.fields['username'].label = "Nombre de usuario"
        self.fields['first_name'].label = "Nombre"
        self.fields['last_name'].label = "Apellido"
        self.fields['dni'].label = "DNI"
        self.fields['country'].label = "Pais"
        self.fields['city'].label = "Ciudad"
        self.fields['address'].label = "Direccion"
        self.fields['number_address'].label = "Numero de puerta"
        self.fields['phone_number'].label = "Telefono"
        self.fields['image_user'].label = "Imagen"
        for form in self.visible_fields():
            form.field.widget.attrs['class'] = 'form-control text-center'

    class Meta:
        model = Users
        fields = (
            "username",
            "first_name",
            "last_name",
            "dni",
            "country",
            "city",
            "address",
            "number_address",
            "phone_number",
            "image_user",
        )

        widgets = {
            "username": forms.TextInput(
                attrs={
                    "placeholder": "Username",
                    "autofocus": "True",
                    "type": "text",
                }
            ),
            "first_name": forms.TextInput(
                attrs={
                    "placeholder": "Nombre",
                    "type": "text",
                }
            ),
            "last_name": forms.TextInput(
                attrs={
                    "placeholder": "Apellido",
                    "type": "text",
                }
            ),
            "dni": forms.NumberInput(
                attrs={
                    "placeholder": "DNI",
                    "type": "number",
                    "min_length": 8,
                    "max_length": 8,
                }
            ),
            "country": forms.Select(
                attrs={
                    "placeholder": "Pais",
                    "type": "text",
                }
            ),
            "city": forms.Select(
                attrs={
                    "placeholder": "Ciudad",
                    "type": "text",
                }
            ),
            "address": forms.TextInput(
                attrs={
                    "placeholder": "Direccion",
                    "type": "text",
                }
            ),
            "number_address": forms.NumberInput(
                attrs={
                    "placeholder": "Numero de puerta",
                    "type": "number",
                }
            ),
            "phone_number": forms.NumberInput(
                attrs={
                    "placeholder": "Telefono",
                    "type": "number",
                }
            ),
            "image_user": forms.FileInput(
                attrs={
                    "placeholder": "Imagen",
                    "type": "file",
                }
            ),
        }

        exclude = [
            "password",
            "email",
        ]

    def save(self, commit=True):
        data = {}
        form = super()
        try:
            if form.is_valid():
                form.save()
            else:
                data["error"] = form.errors
        except Exception as e:
            data["error"] = str(e)
        return data
