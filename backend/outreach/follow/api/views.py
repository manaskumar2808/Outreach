from rest_framework.generics import (
    ListAPIView,
    CreateAPIView,
    RetrieveAPIView,
    RetrieveUpdateAPIView,
    RetrieveDestroyAPIView,
)

from rest_framework.response import Response

from rest_framework.views import APIView

from ..models import Follow
from .serializers import FollowSerializer

class FollowerListAPIView(ListAPIView):
    serializer_class = FollowSerializer
    
    def get_queryset(self,*arg,**kwargs):
        user = self.kwargs['user']
        queryset = Follow.objects.filter(followed__user=user).order_by('-timestamp')
        return queryset

class FollowedListAPIView(ListAPIView):
    serializer_class = FollowSerializer
    
    def get_queryset(self,*arg,**kwargs):
        user = self.kwargs['user']
        queryset = Follow.objects.filter(follower__user=user).order_by('-timestamp')
        return queryset

class FollowAPIView(CreateAPIView):
    queryset = Follow.objects.all()
    serializer_class = FollowSerializer


class UnfollowAPIView(APIView):
    queryset = Follow.objects.all()
    serializer_class = FollowSerializer

    def delete(self,*args,**kwrags):
        followerUser = self.kwargs['follower']
        followedUser = self.kwargs['followed']

        Follow.objects.filter(follower__user=followerUser,followed__user=followedUser).delete()
        return Response({})
    

class IsFollowerAPIView(APIView):
    serializer_class = FollowSerializer

    def get(self,*args,**kwargs):
        followerUser = self.kwargs['follower']
        followedUser = self.kwargs['followed']

        isFollower = Follow.objects.filter(follower__user=followerUser,followed__user=followedUser).count() >  0
        return Response({
            "isFollower": isFollower,
        })


class IsFollowedAPIView(APIView):
    serializer_class = FollowSerializer

    def get(self,*args,**kwargs):
        followerUser = self.kwargs['follower']
        followedUser = self.kwargs['followed']

        isFollowed = Follow.objects.filter(follower__user=followerUser,followed__user=followedUser).count() >  0
        return Response({
            "isFollowed": isFollowed,
        })