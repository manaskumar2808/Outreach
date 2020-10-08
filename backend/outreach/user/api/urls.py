from django.urls import path


from .views import (
    CustomAuthToken,
    RegisterAPIView,
    LoginAPIView,

    ProfileListAPIView,
    ProfileCreateAPIView,
    ProfileRetrieveAPIView,
    ProfileUpdateAPIView,
    ProfileDeleteAPIView,
)

urlpatterns = [
    path('auth-token/',CustomAuthToken.as_view(),name='auth-token-api'),
    path('auth-register/',RegisterAPIView.as_view(),name='auth-register-api'), 
    path('auth-login/',LoginAPIView.as_view(),name='auth-login-api'),

    path('profile/',ProfileListAPIView.as_view(),name='profile-list-api'),
    path('profile/create/',ProfileCreateAPIView.as_view(),name='profile-create-api'),
    path('profile/detail/<int:user>/',ProfileRetrieveAPIView.as_view(),name='profile-detail-api'),
    path('profile/update/<int:user>/',ProfileUpdateAPIView.as_view(),name='profile-update-api'),
    path('profile/delete/<int:user>/',ProfileDeleteAPIView.as_view(),name='profile-delete-api'),
]


