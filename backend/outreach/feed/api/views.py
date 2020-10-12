from .serializers import FeedSerializer
from ..models import Feed

from rest_framework.generics import (
    ListAPIView,
    RetrieveAPIView,
    CreateAPIView,
    RetrieveUpdateAPIView,
    RetrieveDestroyAPIView,
)


class FeedListAPIView(ListAPIView):
    queryset = Feed.objects.all().order_by('-timestamp')
    serializer_class = FeedSerializer


class UserFeedListAPIView(ListAPIView):
    serializer_class = FeedSerializer

    def get_queryset(self,*arg,**kwargs):
        user = self.kwargs['user']
        queryset = Feed.objects.filter(creator__user=user).order_by('-timestamp')
        return queryset
        
    
class FeedRetrieveAPIView(RetrieveAPIView):
    queryset = Feed.objects.all()
    lookup_field = 'id'
    serializer_class = FeedSerializer
    
class FeedCreateAPIView(CreateAPIView):
    queryset = Feed.objects.all()
    serializer_class = FeedSerializer


class FeedUpdateAPIView(RetrieveUpdateAPIView):
    queryset = Feed.objects.all()
    serializer_class = FeedSerializer
    lookup_field = 'id'

    def perform_update(self,serializer):
        serializer.save()

class FeedDeleteAPIView(RetrieveDestroyAPIView):
    queryset = Feed.objects.all()
    serializer_class = FeedSerializer
    lookup_field = 'id' 