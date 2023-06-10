from django import forms
from DB.models import *

from django.contrib.auth import password_validation
from django.core.exceptions import ValidationError
from django.utils.translation import gettext_lazy as _
##################################################################

class UserCreateForm(forms.ModelForm):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        for form in self.visible_fields():
            form.field.widget.attrs['class'] = 'form-control text-center'


    class Meta:
        model = Users
        fields = (
            "username",
            "first_name",
            "last_name",
            "password",
            "email",
            )
        
        widgets = {
            "username": forms.TextInput(
                attrs={
                    "placeholder":"Username",
                    "autofocus":"True",
                    "type":"text",
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
            "email": forms.EmailInput(
                attrs={
                    "placeholder": "mail@example.com",
                }
            ),
            "password": forms.PasswordInput(
                attrs={
                    "placeholder": "Password",
                }
            ),
        }

        exclude = [
            "address",
            "number_address",
            "city",
            "country",
            "phone_number",
            "dni",
            "image_user",
        ]

    def save(self, commit=True):
        instance = super().save(commit=False)
        return instance


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
                    "min_length":8,
                    "max_length":8,
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


class UserRecoveryPass(forms.Form):
    def __init__(self, user, *args, **kwargs):
        self.user = user
        super().__init__(*args, **kwargs)

    error_messages = {
        "password_mismatch": _("Las contraseñas no coinciden"),
    }

    new_password1 = forms.CharField(
        label=_("New password"),
        widget=forms.PasswordInput(attrs={"autocomplete": "new-password"}),
        strip=False,
        help_text=password_validation.password_validators_help_text_html(),
    )

    new_password2 = forms.CharField(
        label=_("New password confirmation"),
        strip=False,
        widget=forms.PasswordInput(attrs={"autocomplete": "new-password"}),
    )

    def clean_new_password2(self):
        password1 = self.cleaned_data.get("new_password1")
        password2 = self.cleaned_data.get("new_password2")
        if password1 and password2:
            if password1 != password2:
                raise ValidationError(
                    self.error_messages["password_mismatch"],
                    code="password_mismatch",
                )
        password_validation.validate_password(password2, self.user)
        return password2

    def save(self, commit=True):
        password = self.cleaned_data["new_password1"]
        self.user.set_password(password)
        if commit:
            self.user.save()
        return self.user
