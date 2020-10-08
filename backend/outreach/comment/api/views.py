from rest_framework.generics import (
    ListAPIView,
    CreateAPIView,
    RetrieveAPIView,
    RetrieveUpdateAPIView,
    RetrieveDestroyAPIView,
)

from ..models import Comment, Reply
from .serializers import CommentSerializer, ReplySerializer

class CommentListAPIView(ListAPIView):
    serializer_class = CommentSerializer
    lookup_field = 'feed'

    def get_queryset(self,*args,**kwargs):
        feed = self.kwargs['feed']
        queryset = Comment.objects.filter(feed=feed).order_by('-timestamp')
        return queryset

class CommentLatestListAPIView(ListAPIView):
    serializer_class = CommentSerializer
    lookup_field = 'feed'

    def get_queryset(self,*args,**kwargs):
        feed = self.kwargs['feed']
        queryset = Comment.objects.filter(feed=feed).order_by('-timestamp')[:2]
        return queryset




class CommentRetrieveAPIView(RetrieveAPIView):
    queryset = Comment.objects.all()
    serializer_class = CommentSerializer
    lookup_field = ['id','feed']   

class CommentCreateAPIView(CreateAPIView):
    queryset = Comment.objects.all()
    serializer_class = CommentSerializer

class CommentUpdateAPIView(RetrieveUpdateAPIView):
    queryset = Comment.objects.all()
    serailizer_class = CommentSerializer
    lookup_field = 'id'

class CommentDeleteAPIView(RetrieveDestroyAPIView):
    queryset = Comment.objects.all()
    serializer_class = CommentSerializer
    lookup_field = 'id'



class ReplyListAPIView(ListAPIView):
    serializer_class = ReplySerializer

    def get_queryset(self,*args,**kwargs):
        queryset = Reply.objects.filter(comment = self.kwargs['comment']).order_by('-timestamp')
        return queryset

class ReplyLatestListAPIView(ListAPIView):
    serializer_class = ReplySerializer

    def get_queryset(self,*args,**kwargs):
        queryset = Reply.objects.filter(comment = self.kwargs['comment']).order_by('-timestamp')[:2]
        return queryset

class ReplyCreateAPIView(CreateAPIView):
    queryset = Reply.objects.all()
    serializer_class = ReplySerializer

class ReplyRetrieveAPIView(RetrieveAPIView):
    queryset = Reply.objects.all()
    serializer_class = ReplySerializer
    lookup_field = 'id'

class ReplyUpdateAPIView(RetrieveUpdateAPIView):
    queryset = Reply.objects.all()
    serializer_class = ReplySerializer
    lookup_field = 'id'

class ReplyDeleteAPIView(RetrieveDestroyAPIView):
    queryset = Reply.objects.all()
    serializer_class = ReplySerializer
    lookup_field = 'id'

