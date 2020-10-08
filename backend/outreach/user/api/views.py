from rest_framework.authtoken.views import ObtainAuthToken
from rest_framework.authtoken.models import Token
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.permissions import (
    IsAuthenticated,
    AllowAny,
)

from django.contrib.auth.models import User


class CustomAuthToken(ObtainAuthToken):
    def post(self, request, *args, **kwargs):
        serializer = self.serializer_class(data=request.data,context={'request': request})
        serializer.is_valid(raise_exception=True)
        user = serializer.validated_data['user']
        token, created = Token.objects.get_or_create(user=user)
        return Response({
            'token': token.key,
            'user_id': user.pk,
            'email': user.email,
            'userName': user.username,
        })



################## profile manager classes ###################


from rest_framework.generics import (
    ListAPIView,
    CreateAPIView,
    UpdateAPIView,
    RetrieveAPIView,
    DestroyAPIView,
    RetrieveUpdateAPIView,
    RetrieveDestroyAPIView,
)

from .serializers import ProfileSerializer, UserCreateSerializer, UserLoginSerializer
from ..models import Profile


class RegisterAPIView(CreateAPIView):
    queryset = User.objects.all()
    permission_classes = [AllowAny]
    serializer_class = UserCreateSerializer


class LoginAPIView(APIView):
    permission_classes = [AllowAny]
    serializer_class = UserLoginSerializer

    def post(self,request):
        print(self.request.user)
        serializer = UserLoginSerializer(data=request.data)
        if serializer.is_valid(raise_exception=True):
           data = serializer.data
           return Response(data)


class ProfileListAPIView(ListAPIView):
    queryset = Profile.objects.all()
    serializer_class = ProfileSerializer

    
class ProfileRetrieveAPIView(RetrieveAPIView):
    queryset = Profile.objects.all()
    serializer_class = ProfileSerializer
    lookup_field = 'user'

class ProfileCreateAPIView(CreateAPIView):
    queryset = Profile.objects.all()
    serializer_class = ProfileSerializer

    def perform_create(self,serializer):
        serializer.save()

class ProfileUpdateAPIView(RetrieveUpdateAPIView):
    queryset = Profile.objects.all()
    serializer_class = ProfileSerializer
    lookup_field = 'user'

    def perform_update(self,serializer):
        serializer.save()
    
class ProfileDeleteAPIView(RetrieveDestroyAPIView):
    queryset = Profile.objects.all()
    serializer_class = ProfileSerializer
    lookup_field = 'user'