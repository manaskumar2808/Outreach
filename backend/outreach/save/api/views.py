from rest_framework.generics import (
    ListAPIView,
    CreateAPIView,
    RetrieveAPIView,
    RetrieveUpdateAPIView,
    RetrieveDestroyAPIView,
)

from rest_framework.response import Response

from rest_framework.views import APIView

from ..models import Save
from .serializers import SaveSerializer

class SaveListAPIView(ListAPIView):
    serializer_class = SaveSerializer

    def get_queryset(self,*args,**kwargs):
        user = self.kwargs['user']
        queryset = Save.objects.filter(saver__user=user).order_by('-timestamp')
        return queryset

class SaveCountAPIView(APIView):
    serializer_class = SaveSerializer

    def get(self,*args,**kwargs):
        feed = self.kwargs['feed']
        count = Save.objects.filter(feed=feed).count()
        return Response({"count": count})

class IsSaved(APIView):
    serializer_class = SaveSerializer

    def get(self,*args,**kwargs):
        feed = self.kwargs['feed']
        user = self.kwargs['user']
        isSaved = Save.objects.filter(feed=feed,saver__user=user).count() > 0
        return Response({'isSaved': isSaved})

class SaveLatestListAPIView(ListAPIView):
    serializer_class = SaveSerializer

    def get_queryset(self,*args,**kwargs):
        user = self.kwargs['user']
        queryset = Save.objects.filter(saver__user=user).order_by('-timestamp')[:4]
        return queryset


class SaveRetrieveAPIView(RetrieveAPIView):
    serializer_class = SaveSerializer
    lookup_field = 'id'

    def get_queryset(self,*args,**kwargs):
        feed = self.kwargs['feed']
        user = self.kwargs['user']
        queryset = Save.objects.filter(feed=feed,saver__user=user).order_by('-timestamp').first()
        if(queryset.exists()):
            return queryset
        return None


class SaveCreateAPIView(CreateAPIView):
    queryset = Save.objects.all()
    serializer_class = SaveSerializer

class SaveUpdateAPIView(RetrieveUpdateAPIView):
    queryset = Save.objects.all()
    serailizer_class = SaveSerializer
    lookup_field = 'id'

class SaveDeleteAPIView(RetrieveDestroyAPIView):
    queryset = Save.objects.all()
    serializer_class = SaveSerializer


class UnsaveAPIView(APIView):
    serializer_class = SaveSerializer

    def delete(self,*args,**kwargs):
        feed = self.kwargs['feed']
        user = self.kwargs['user']
        queryset = Save.objects.filter(feed=feed,saver__user=user).first().delete()
        return Response({})

