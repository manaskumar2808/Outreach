from rest_framework.generics import (
    ListAPIView,
    CreateAPIView,
    RetrieveAPIView,
    RetrieveUpdateAPIView,
    RetrieveDestroyAPIView,
)

from rest_framework.response import Response

from rest_framework.views import APIView

from ..models import Like
from .serializers import LikeSerializer

class LikeListAPIView(ListAPIView):
    serializer_class = LikeSerializer
    lookup_field = 'feed'

    def get_queryset(self,*args,**kwargs):
        feed = self.kwargs['feed']
        queryset = Like.objects.filter(feed=feed).order_by('-timestamp')
        return queryset


class CLikeListAPIView(ListAPIView):
    serializer_class = LikeSerializer

    def get_queryset(self,*args,**kwargs):
        comment = self.kwargs['comment']
        queryset = Like.objects.filter(comment=comment).order_by('-timestamp')
        return queryset


class LikeCountAPIView(APIView):
    serializer_class = LikeSerializer
    lookup_field = 'feed'

    def get(self,*args,**kwargs):
        feed = self.kwargs['feed']
        count = Like.objects.filter(feed=feed).count()
        return Response({"count": count})

class CLikeCountAPIView(APIView):
    serializer_class = LikeSerializer

    def get(self,*args,**kwargs):
        comment = self.kwargs['comment']
        count = Like.objects.filter(comment=comment).count()
        return Response({"count": count})


class IsLiked(APIView):
    serializer_class = LikeSerializer
    lookup_field = 'feed'

    def get(self,*args,**kwargs):
        feed = self.kwargs['feed']
        user = self.kwargs['user']
        isLiked = Like.objects.filter(feed=feed,liker__user=user).count() > 0
        return Response({'isLiked': isLiked})


class CIsLiked(APIView):
    serializer_class = LikeSerializer

    def get(self,*args,**kwargs):
        comment = self.kwargs['comment']
        user = self.kwargs['user']
        isLiked = Like.objects.filter(comment=comment,liker__user=user).count() > 0
        return Response({'isLiked': isLiked})


class LikeLatestListAPIView(ListAPIView):
    serializer_class = LikeSerializer
    lookup_field = 'feed'

    def get_queryset(self,*args,**kwargs):
        feed = self.kwargs['feed']
        queryset = Like.objects.filter(feed=feed).order_by('-timestamp')[:4]
        return queryset


class CLikeLatestListAPIView(ListAPIView):
    serializer_class = LikeSerializer

    def get_queryset(self,*args,**kwargs):
        comment = self.kwargs['comment']
        queryset = Like.objects.filter(comment=comment).order_by('-timestamp')[:4]
        return queryset


class LikeRetrieveAPIView(RetrieveAPIView):
    serializer_class = LikeSerializer
    lookup_field = 'id'

    def get_queryset(self,*args,**kwargs):
        feed = self.kwargs['feed']
        user = self.kwargs['user']
        queryset = Like.objects.filter(feed=feed,liker__user=user).order_by('-timestamp').first()
        if(queryset.exists()):
            return queryset
        return None


class LikeCreateAPIView(CreateAPIView):
    queryset = Like.objects.all()
    serializer_class = LikeSerializer

class LikeUpdateAPIView(RetrieveUpdateAPIView):
    queryset = Like.objects.all()
    serailizer_class = LikeSerializer
    lookup_field = 'id'

class LikeDeleteAPIView(RetrieveDestroyAPIView):
    queryset = Like.objects.all()
    serializer_class = LikeSerializer


class UnlikeAPIView(APIView):
    serializer_class = LikeSerializer

    def delete(self,*args,**kwargs):
        feed = self.kwargs['feed']
        user = self.kwargs['user']
        queryset = Like.objects.filter(feed=feed,liker__user=user).first().delete()
        return Response({})


class CUnlikeAPIView(APIView):
    serializer_class = LikeSerializer

    def delete(self,*args,**kwargs):
        comment = self.kwargs['comment']
        user = self.kwargs['user']
        queryset = Like.objects.filter(comment=comment,liker__user=user).first().delete()
        return Response({})