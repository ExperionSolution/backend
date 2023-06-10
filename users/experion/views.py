from django.shortcuts import redirect, render, HttpResponseRedirect

from django.contrib.auth.views import LoginView, LogoutView, PasswordResetDoneView, PasswordResetView
from django.contrib.auth.forms import PasswordChangeForm
from django.contrib.auth.models import Group
from django.contrib.auth.mixins import LoginRequiredMixin
from django.contrib.auth import update_session_auth_hash
from django.contrib.auth import login as auth_login
from django.contrib.sites.shortcuts import get_current_site
from django.contrib.auth.tokens import default_token_generator

from django.urls import reverse, reverse_lazy

from django.utils.text import capfirst
from django.utils.http import urlsafe_base64_encode, urlsafe_base64_decode
from django.utils.encoding import force_bytes, force_str
from django.utils.decorators import method_decorator
from django.utils.translation import gettext_lazy as _

from django.views.generic import TemplateView, CreateView, UpdateView, FormView, View
from django.views.decorators.debug import sensitive_post_parameters
from django.views.decorators.cache import never_cache

from django.forms.utils import ErrorList

from django.core.exceptions import ImproperlyConfigured
from django.core.mail import send_mail

from django.template.loader import render_to_string

from django.conf import settings

from DB.models import *
from .forms import *
########################################################################


#--------------------LOGIN-------------------------#
class LoginView(LoginView):
    template_name = 'login.html'        

    def dispatch(self, request, *args, **kwargs):
        if request.user.is_authenticated:
            return redirect('index')
        return super().dispatch(request, *args, **kwargs)

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['title'] = "Inicio de sesion"

        return context


class SesionGroupView(View):
    def get(self, request, *args, **kwargs):
        try:
            request.session['group'] = Group.objects.get(pk=self.kwargs['pk'])
        except:
            pass
        return redirect('inicio')
    

#--------------------USER CREATION-------------------------#
class UserCreate(CreateView):
    model = Users
    form_class = UserCreateForm
    template_name = 'register.html'

    def dispatch(self, request, *args, **kwargs):
        if request.user.is_authenticated:
            return redirect('index')
        return super().dispatch(request, *args, **kwargs)
    
    def form_valid(self, form):
        form.instance.first_name = capfirst(form.instance.first_name)
        form.instance.last_name = capfirst(form.instance.last_name)
        form.instance.is_active = False
        usuario = form.save(commit=False)
        usuario.save()
        self.enviar_correo_activacion(usuario, self.request)

        if form.errors:
            self.object = None
            errors = form.errors.get_json_data(escape_html=True)
            for field, field_errors in errors.item():
                form.add_error(field, ErrorList(field_errors))
            return self.render_ro_response(self.get_context_data(form=form))
        return super().form_valid(form)
  
    def get_success_url(self):
        return reverse('login')

    def enviar_correo_activacion(self, usuario, request):
        current_site = get_current_site(request)
        uid = urlsafe_base64_encode(force_bytes(usuario.id))
        activate_url = reverse('user_activate', kwargs={'uidb64': uid, 'token': default_token_generator.make_token(usuario)})
        activation_link = f"http://{current_site.domain}{activate_url}"        
        subject = 'Activación de cuenta'
        message = render_to_string('activate_account.html', {
            'usuario': usuario,
            'activation_link':activation_link,
            'domain': current_site.domain,
            'uid': urlsafe_base64_encode(force_bytes(usuario.id)),
            'token': default_token_generator.make_token(usuario),
        })
        send_mail(subject, message, settings.EMAIL_HOST_USER, [usuario.email])
        
    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['title'] = 'Registro de usuario'

        return context

class UserActivate(TemplateView):
    def get(self, request, uidb64, token, *args, **kwargs):
        try:
            uid = force_str(urlsafe_base64_decode(uidb64))
            usuario = Users.objects.get(pk=uid)
        except (TypeError, ValueError, OverflowError, Users.DoesNotExist):
            usuario = None

        if usuario is not None and default_token_generator.check_token(usuario, token):
            usuario.is_active = True
            usuario.save()
            return redirect('login')
        else:
            print(uid, usuario)
            return redirect('register')
    

#--------------------USER DATA EDIT-------------------------#
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
        user_id = self.kwargs.get('pk')     
        if user_id != request.user.id:
            return redirect('index')   
        return super().dispatch(request, *args, **kwargs)

    def get_form(self, form_class=None):
        form = PasswordChangeForm(user=self.request.user)
        return form

    def get_object(self, querysert=None):
        return self.request.user

    def post(self, request, *args, **kwargs):
        data = {}
        form = PasswordChangeForm(user = request.user, data= request.POST)

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



#--------------------PASSWORD RECOVERY-------------------------#
class PasswordRecoveryView(PasswordResetView):
    template_name = 'password_recovery_form.html'
    email_template_name = 'password_recovery_email.html'
    success_url = '../reset_password_sent'

    def form_valid(self, form):
        try:
            current_site = get_current_site(self.request)
            email = self.request.POST['email']
            usuario = Users.objects.get(email=email)

            uid = urlsafe_base64_encode(force_bytes(usuario.pk))
            token = default_token_generator.make_token(usuario)

            reset_url = reverse('password_reset_confirm', kwargs={'uidb64': uid, 'token': token})
            reset_link = f"http://{current_site.domain}{reset_url}"

            subject = 'Recuperacion de contraseña'
            message = render_to_string('password_recovery_email.html', {
                'usuario': usuario,
                'reset_link': reset_link,
                'domain': current_site.domain,
                'uid': uid,
                'token': token,
            })
            send_mail(subject, message, settings.EMAIL_HOST_USER, [usuario.email])        
            return super().form_valid(form)
        except:
            return render(self.request,'password_recovery_form.html', {"error": "El email ingresado no se encuentra registrado"})


class PasswordRecoveryConfirm(FormView):
    form_class = UserRecoveryPass
    post_reset_login = False
    post_reset_login_backend = None
    reset_url_token = "set-password"
    success_url = reverse_lazy("reset_password_complete")
    template_name = "password_recovery_confirm.html"
    title = _("Enter new password")
    token_generator = default_token_generator

    @method_decorator(sensitive_post_parameters())
    @method_decorator(never_cache)
    def dispatch(self, *args, **kwargs):
        if "uidb64" not in kwargs or "token" not in kwargs:
            raise ImproperlyConfigured(
                "The URL path must contain 'uidb64' and 'token' parameters."
            )

        self.validlink = False
        self.user = self.get_user(kwargs["uidb64"])

        if self.user is not None:
            token = kwargs["token"]
            if token == self.reset_url_token:
                session_token = self.request.session.get('reset_token')
                if self.token_generator.check_token(self.user, session_token):
                    self.validlink = True
                    return super().dispatch(*args, **kwargs)
            else:
                if self.token_generator.check_token(self.user, token):
                    self.request.session['reset_token'] = token
                    redirect_url = self.request.path.replace(
                        token, self.reset_url_token
                    )
                    return HttpResponseRedirect(redirect_url)

        return self.render_to_response(self.get_context_data())

    def get_user(self, uidb64):
        UserModel = Users
        try:
            uid = urlsafe_base64_decode(uidb64).decode()
            user = UserModel._default_manager.get(pk=uid)
        except (
            TypeError,
            ValueError,
            OverflowError,
            UserModel.DoesNotExist,
            ValidationError,
        ):
            user = None
        return user

    def get_form_kwargs(self):
        kwargs = super().get_form_kwargs()
        kwargs["user"] = self.user
        return kwargs

    def form_valid(self, form):
        user = form.save()
        del self.request.session['reset_token']
        if self.post_reset_login:
            auth_login(self.request, user, self.post_reset_login_backend)
        return super().form_valid(form)

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        if self.validlink:
            context["validlink"] = True
        else:
            context.update(
                {
                    "form": None,
                    "title": _("Password reset unsuccessful"),
                    "validlink": False,
                }
            )
        return context

class PasswordRecoveryDone(PasswordResetDoneView):
    template_name = 'password_recovery_done.html'


class PasswordRecoveryComplete(TemplateView):
    template_name = "password_recovery_complete.html"
    title = _("Password reset complete")

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context["login_url"] = redirect(settings.LOGIN_URL)
        return context


#--------------------INDEX-------------------------#
class Index(TemplateView):
    template_name = "index.html"


