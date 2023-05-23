from django.shortcuts import redirect, render
from django.contrib.auth.forms import PasswordChangeForm
from django.utils.text import capfirst
from django.urls import reverse
from django.views.generic import UpdateView, FormView, View
from django.contrib.auth.mixins import LoginRequiredMixin
from django.contrib.auth import update_session_auth_hash
from django.contrib.auth.models import Group

from DB.models import *
from .forms import *

#########################################################################

class SesionGroupView(View):
    def get(self, request, *args, **kwargs):
        try:
            request.session['group'] = Group.objects.get(pk=self.kwargs['pk'])
        except:
            pass
        return redirect('inicio')
    

class UserEdit(LoginRequiredMixin, UpdateView):
    model = Users
    form_class = UserEditForm
    template_name = 'useredit.html'

    def dispatch(self, request, *args, **kwargs):
        self.object = self.get_object()
        if self.object.username != request.user.username:
            return redirect('index')
        return super().dispatch(request, *args, **kwargs)

    def form_valid(self, form):
        form.instance.first_name = capfirst(form.instance.first_name)
        form.instance.last_name = capfirst(form.instance.last_name)
        form.instance.address = capfirst(form.instance.address)
        form.instance.country = capfirst(form.instance.country)
        form.instance.city = capfirst(form.instance.city)
        return super().form_valid(form)

    def get_success_url(self):
        return reverse('index')

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['title'] = 'Edicion de usuario'

        return context


class PasswordEdit(LoginRequiredMixin, FormView):
    model = Users
    form_class = PasswordChangeForm
    template_name = 'password_edit.html'

    def dispatch(self, request, *args, **kwargs):
        return super().dispatch(request, *args, **kwargs)

    def get_form(self, form_class=None):
        form = PasswordChangeForm(user=self.request.user)
        return form

    def post(self, request, *args, **kwargs):
        data = {}
        form = PasswordChangeForm(user=request.user, data=request.POST)

        if form.is_valid():
            form.save()
            update_session_auth_hash(request, form.user)
            return redirect('index')
        else:
            data['error'] = form.errors

        return render(request, "password_edit.html", {"form": form})

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['title'] = 'Edicion de contraseña'

        return context
