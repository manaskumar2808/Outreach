import uuid

from rest_framework import serializers
from rest_framework.authtoken.models import Token

from django.contrib.auth.models import User
from django.core.exceptions import ValidationError
from django.db.models import Q

from ..models import Profile

class ProfileSerializer(serializers.ModelSerializer):
    class Meta:
        model = Profile
        fields = '__all__' 
        

class UserCreateSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = [
            'id',
            'username',
            'email',
            'password',
        ]
        extra_kwargs = {
            'password': {
                'write_only': True,
            }
        }

    def create(self,validated_data):
        username = validated_data['username']
        email = validated_data['email']
        password = validated_data['password']
        user = User(
            username = username,
            email = email,
        )
        user.set_password(password)
        user.save()
        validated_data['id'] = user.id
        return validated_data
    
    def validate_email(self,value):
        data = self.get_initial()
        user = User.objects.filter(email = data.get('email'))
        if user.exists():
            raise ValidationError("Email Already Exists!")
        
        return value
    
    def validate_username(self,value):
        data = self.get_initial()
        user = User.objects.filter(username = data.get('username'))
        if user.exists():
            raise ValidationError("Username Already Exists!")
        
        return value


class UserLoginSerializer(serializers.ModelSerializer):
    token = serializers.CharField(allow_blank=True,read_only=True)
    username = serializers.CharField(required=False,allow_blank=True)
    email = serializers.CharField(label='Email Address',required=False,allow_blank=True)
    class Meta:
        model = User
        fields = [
            'id',
            'username',
            'email',
            'password',
            'token',
        ]
        extra_kwargs = {
            'password': {
                'write_only': True,
            }
        }

    def validate(self,data):
        email = data.get('email')
        username = data.get('username')
        password = data.get('password')
        if not email and not username:
            raise ValidationError('A username or email is required!')
        user = User.objects.filter(
            Q(email=email) | Q(username=username)
        ).distinct()
        if(user.exists() and user.count() == 1):
            user_obj = user.first()
        else:
            raise ValidationError("This username/email is not valid")

        if user_obj:
            data['id'] = user_obj.id
            if not user_obj.check_password(password):
                raise ValidationError("Incorrect credentials!")
                
        token, created = Token.objects.get_or_create(user=user_obj)
        data['token'] = token
        return data