from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from .models import Users

##########################################################################

class UsersAdmin(UserAdmin):
    list_display = (
        "username",
        "is_active",
        "is_staff",
        "id",
        "dni",
        "phone_number",
    )

    list_per_page = 25
    exclude = ("user_update", "date_update", "usuario",)

##########################################################################


admin.site.register(Users, UsersAdmin)
